import * as React from "react";
import AppBar from "@mui/material/AppBar";
import Box from "@mui/material/Box";
import Toolbar from "@mui/material/Toolbar";
import Typography from "@mui/material/Typography";
import Container from "@mui/material/Container";
import Button from "@mui/material/Button";
// import AdbIcon from "@mui/icons-material/Adb";
import Avatar from "@mui/material/Avatar";
import { useNavigate } from "react-router-dom";
import logo from "../assets/images/logo.png";
import { useSelector } from "react-redux";
import axios from "axios";
import { deleteAll } from "../store/reducers/user";
import {
  setAccessToken,
  setApproved,
  setRefreshToken,
} from "../store/reducers/user";

import { useDispatch } from "react-redux";
// const pages = ["서비스 소개", "사용방법", "개발자 소개", "로그인"];
const pages = ["서비스 소개", "사용방법", "개발자 소개"];
const url = ["/", "/#", "/contact-us"];

function ResponsiveAppBar() {
  //클릭한 pages의 인덱스 번호url로 이동

  const accessToken = useSelector((state) => state.user.accessToken);
  const dispatch = useDispatch();

  const renderAuthButton = () => {
    if (accessToken) {
      return (
        <>
          <Button
            sx={{ my: 2, color: "white", display: "block" }}
            onClick={() => handleClick(navigate("/im"))}
            style={{ fontFamily: "gmarketSans" }}
          >
            내 정보
          </Button>
          <Button
            sx={{ my: 2, color: "white", display: "block" }}
            style={{ fontFamily: "gmarketSans" }}
            onClick={() => {
              dispatch(deleteAll());
              axios({
                method: "post",
                url: "https://k9d102.p.ssafy.io/api/ceo/signout",
                // url: "http://localhost:9999/api/ceo/signout",
                headers: {
                  Authorization: `Bearer ${accessToken}`,
                },
              })
                .then(() => {
                  dispatch(setAccessToken(null));
                  dispatch(setRefreshToken(null));
                  dispatch(setApproved(false));
                  navigate("/");
                })
                .catch((err) => {
                  console.log(err);
                  navigate("/");
                });
            }}
          >
            로그아웃
          </Button>
        </>
      );
    } else {
      return (
        <Button
          sx={{ my: 2, color: "white", display: "block" }}
          style={{ fontFamily: "gmarketSans" }}
          onClick={() => navigate("/signin")}
        >
          로그인
        </Button>
      );
    }
  };

  const navigate = useNavigate();
  const handleClick = (index) => {
    console.log("Clicked index:", index);
    navigate(url[index]);
  };

  return (
    <AppBar position="static" style={{ backgroundColor: "#9B5748" }}>
      <Container maxWidth="xl">
        <Toolbar disableGutters>
          <Avatar alt="Remy Sharp" src={logo} />
          <Typography
            variant="h6"
            noWrap
            component="a"
            sx={{
              mr: 2,
              display: { xs: "none", md: "flex" },
              fontFamily: "monospace",
              fontWeight: 700,
              letterSpacing: ".3rem",
              color: "inherit",
              textDecoration: "none",
            }}
            style={{ fontFamily: "gmarketSans" }}
            href="/"
          >
            근카 가카?
          </Typography>

          <Box
            sx={{
              flexGrow: 1,
              display: { xs: "none", md: "flex" },
              alignContent: "flex-end",
              justifyContent: "flex-end",
            }}
          >
            {pages.map((page) => (
              <Button
                key={page}
                sx={{ my: 2, color: "white", display: "block" }}
                onClick={() => handleClick(pages.indexOf(page))}
                style={{ fontFamily: "gmarketSans" }}
              >
                {page}
              </Button>
            ))}
            {renderAuthButton()}
          </Box>
        </Toolbar>
      </Container>
    </AppBar>
  );
}
export default ResponsiveAppBar;
