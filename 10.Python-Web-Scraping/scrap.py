#!/usr/bin/env python
# coding: utf-8

# In[1]:


import selenium
from selenium import webdriver
from selenium.webdriver.firefox.service import Service
from webdriver_manager.firefox import GeckoDriverManager
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
from datetime import date, datetime
import pandas as pd
import pathlib
import json   
from sqlalchemy import create_engine


# Convert to df to Json List 
df_clk = pd.read_excel('list/clklist.xlsx')
df_json = df_clk.to_json(orient="records", indent=4, force_ascii = False)
clklist = json.loads(df_json)

org_name = 'CLK_'
end_year = 2022
end_day = 29
end_month = 12
dfbase=pd.DataFrame()
dfall=pd.DataFrame()
error_dict = []

sheet = datetime.now().strftime("%H_%M")
file_name = datetime.now().strftime("%m_%d_%Y_%H")
file_path = 'Data/' + org_name + file_name +'.xlsx'

file = pathlib.Path(file_path)

if file.exists()==False:
    with pd.ExcelWriter(file_path, mode='w', engine="openpyxl") as writer:
        dfbase.to_excel(writer,index=False)

with pd.ExcelWriter(file_path, mode='a', engine="openpyxl",if_sheet_exists='replace') as writer:
    dfbase.to_excel(writer,index=False)
    
engine = create_engine('mysql+pymysql://root:example@35.202.103.123:31000/cons', echo=False)
df_sql = pd.read_sql_table(
    'data_by_months',
    con=engine)


for i in clklist:
    print("Started 1.!............")

    try:
        dfbase=pd.DataFrame()
        Hizmet_Noktası_No = i['Hizmet_Noktası_No']
        Sayaç_Seri_No = i['Sayaç_Seri_No']
        Tesis_ID =i['Tesis_ID']
        username = i['username']
        password = i['password']

        try:
            options = Options()
            options.headless = False
            browser = webdriver.Firefox(service=Service(executable_path=GeckoDriverManager().install()), options=options)
            browser.maximize_window()

            url = 'https://osos.akdenizedas.com.tr/osos/login.iface'
            browser.get(url)
            browser.maximize_window()
            time.sleep(5)
            usernameInput = browser.find_element('name','frmLoginPanel:inpUser')
            passwordInput = browser.find_element('name','frmLoginPanel:inpPass')

            usernameInput.send_keys(username)
            passwordInput.send_keys(password)

            passwordInput.send_keys(Keys.ENTER)

            time.sleep(2)
            url2 = 'https://osos.akdenizedas.com.tr/osos/counterInfo.iface'
            browser.get(url2)
            browser.maximize_window()
            el = WebDriverWait(browser, 10).until(EC.presence_of_element_located((By.XPATH, '/html/body/div[2]/form/div[3]/table[2]/tbody/tr/td[2]/table/tbody/tr')))
            actions = ActionChains(browser)
            time.sleep(4)
            actions.click(el).perform()

            elm = WebDriverWait(browser, 10).until(EC.presence_of_element_located((By.XPATH, '/html/body/div[2]/form/div[4]/table/tbody/tr[1]/td/table/tbody/tr/td[1]/table/tbody/tr[2]/td[2]/a/div/table/tbody/tr')))
            actions = ActionChains(browser)
            time.sleep(4)
            actions.click(elm).perform()
            time.sleep(4)

        except Exception as e:
            print(e)
            browser.quit()
            temp_error = {'username': username,'password': password}
            error_dict.append(temp_error) 
            print("Browser Error!............")

        ssn_values = [Sayaç_Seri_No]
        if df_sql[df_sql['ssno'].isin(ssn_values)].empty:
            max_dates = pd.to_datetime('today') - pd.offsets.MonthEnd()
        else:
            max_dates = df_sql[df_sql['ssno'].isin(ssn_values)]['date'].max()

        last_rec = datetime.now().replace(microsecond=0, second=0)

        try:
            table =WebDriverWait(browser,10).until(EC.visibility_of_element_located((By.XPATH,'//table[@id="frmCounterProfiles:j_id131:0:dailyList"]'))).get_attribute("outerHTML")
            if not table:
              # code to execute if the table variable is null or empty
              last_rec = datetime.now()
              print("Table does not exist!............")
            else:
              df=pd.read_html(str(table),thousands = '.', decimal= ',')[0]
              df.Zaman = pd.to_datetime(df.Zaman)
              dfbase = pd.concat([dfbase, df], axis=0)
              last_rec = dfbase.Zaman.tail(1).item()

            while last_rec > max_dates :
                try:
                    elmn = WebDriverWait(browser, 10).until(EC.presence_of_element_located((By.XPATH, '//*[@id="frmCounterProfiles:j_id131:0:j_id167-0-2"]')))
                    actions = ActionChains(browser)
                    time.sleep(4)
                    actions.click(elmn).perform()
                    time.sleep(4)
                    table =WebDriverWait(browser,10).until(EC.visibility_of_element_located((By.XPATH,'//table[@id="frmCounterProfiles:j_id131:0:dailyList"]'))).get_attribute("outerHTML")
                    time.sleep(2)
                    df=pd.read_html(str(table),thousands = '.', decimal= ',')[0]
                    df.Zaman = pd.to_datetime(df.Zaman)
                    dfbase = pd.concat([dfbase, df], axis=0)
                    last_rec = dfbase.Zaman.tail(1).item()
                except Exception as e:
                    print(e)


        except Exception as e:
            print(e)
            print("end of While!............")
            browser.quit()

        browser.quit()

        print("Dfbase Started!............")

        dfbase = dfbase[dfbase["Zaman"] > max_dates]

        dfbase['username'] = username
        dfbase['Hizmet_Noktası_No'] = Hizmet_Noktası_No
        dfbase['Sayaç_Seri_No'] = Sayaç_Seri_No

        dfbase = dfbase[dfbase['Zaman'].dt.minute == 0]
        dfbase['facility_id'] = Tesis_ID

        dfall = pd.concat([dfall, dfbase], axis=0)

        sheet = str(username)
        with pd.ExcelWriter(file_path, mode="a", engine="openpyxl",if_sheet_exists='replace') as writer:
            dfbase.to_excel(writer,sheet_name=sheet,index=False)
    except:
        temp_error = {'username': username,'password': password}
        error_dict.append(temp_error) 

try:
    dfall = dfall.rename(columns={
        'Zaman': 'date', 
        'Aktif Enerji(kWh)': 'active',
        'Endüktif Tüketim Ri(kVArh)': 'inductive', 
        'Kapasitif Tüketim Rc(kVArh)': 'capacitive',
        'Hizmet_Noktası_No': 'hno', 
        'Sayaç_Seri_No': 'ssno'
    })
    dfall = dfall[['date', 'active', 'inductive', 'capacitive', 'hno', 'ssno', 'facility_id']]
    dfall.dropna(inplace=True)
    dfall.to_sql(name="consumptions" ,con=engine,index=False, if_exists='append')
    print('Sucessfully written to Remote Database!!!')
    

except Exception as e:
    print(e)

sheet = str("dfall")
with pd.ExcelWriter(file_path, mode="a", engine="openpyxl",if_sheet_exists='replace') as writer:
    dfall.to_excel(writer,sheet_name=sheet,index=False)

df_error = pd.DataFrame(error_dict)
sheet_er = 'ERROR'
with pd.ExcelWriter(file_path, mode="a", engine="openpyxl",if_sheet_exists='replace') as writer:
    df_error.to_excel(writer,sheet_name=sheet_er,index=False)


# In[ ]:




