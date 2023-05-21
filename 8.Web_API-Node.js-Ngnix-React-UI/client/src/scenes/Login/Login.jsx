import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";
import { LoginUser, reset } from "../../state/index.js";
import FlexBetween from "components/FlexBetween";
import {
  Box,
  Button,
  TextField,
  FormControlLabel,
  Checkbox,
  Typography,
} from "@mui/material";
import InputMask from 'react-input-mask';

const Login = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { user, isError, isSuccess, isLoading, message } = useSelector(
    (state) => state.auth
  );
  const [rememberMe, setRememberMe] = useState(false);
  const handleRememberMeChange = (event) => {
    setRememberMe(event.target.checked);
  };

  useEffect(() => {
    if (user || isSuccess) {
      navigate("/dashboard");
    }
    dispatch(reset());
  }, [user, isSuccess, dispatch, navigate]);

  const Auth = (e) => {
    e.preventDefault();
    if (!email || !password) {
      return;
    }
    dispatch(LoginUser({ email, password, rememberMe }));
  };

  useEffect(() => {
    if (isError) {
      setTimeout(() => {
        dispatch(reset());
      }, 5000);
    }
    if (!rememberMe) {
      setEmail("");
      setPassword("");
    }
  }, [isError, dispatch, rememberMe]);

  return (
    <FlexBetween>
      <Box
        display="flex"
        justifyContent="center"
        alignItems="center"
        style={{ height: "100%", width: "100%", margin: "1.5rem 2.5rem" }}
      >
        <form onSubmit={Auth}>
          {isError && (
            <Typography variant="subtitle1" align="center">
              {message}
            </Typography>
          )}
          <Typography variant="h5" gutterBottom>
            Giriş Yap!
          </Typography>
          <TextField
            label="Email"
            fullWidth
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="Email"
            margin="normal"
            marginTop="1rem"
            style={{ backgroundColor: "transparent" }}
          />
          <TextField
              fullWidth
              label="Password"
              type="password"
              value={password}
              margin="normal"
              marginTop="1rem"
              placeholder="******"
              onChange={(e) => setPassword(e.target.value)}
              style={{ backgroundColor: "transparent" }}
          >
              <InputMask
                  name='password'
                  mask="*"
                  type="password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="******"
              />
          </TextField>

          <Button
            type="submit"
            variant="contained"
            color="primary"
            fullWidth
            style={{ marginTop: "1rem" }}
          >
            {isLoading ? "Loading..." : "Giriş!"}
          </Button>
        </form>
      </Box>
    </FlexBetween>
  );
};

export default Login;
