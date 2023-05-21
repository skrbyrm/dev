import React from "react";
import { Box, useMediaQuery } from "@mui/material";
import { Outlet } from "react-router-dom";
import { useSelector } from "react-redux";
import Navbar from "components/Navbar";

const Layout = () => {
  const isNonMobile = useMediaQuery("(min-width: 600px)");
  const {user} = useSelector((state) => state.auth);

  return (
    <Box display={isNonMobile ? "flex" : "block"} width="100%" height="100%">
      <Box flexGrow={1}>
        <Navbar
          user={user || {}}
        />
        <Outlet />
      </Box>
    </Box>
  );
};

export default Layout;
