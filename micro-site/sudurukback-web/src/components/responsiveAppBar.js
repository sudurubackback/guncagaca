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
const pages = [
  "서비스소개",
  "포팅메뉴얼",
  "사용방법",
  "고객앱다운로드",
  "개발자소개",
];

const privatePages = ["포팅메뉴얼", "사용방법"];
const url = [
  "/",
  "https://bald-paper-b60.notion.site/Deploy-52f68c7b7f7b4816a941f90ad55531e6?pvs=4",
  "https://bald-paper-b60.notion.site/07471eaefe88485abbe94ba5e2242853?pvs=4",
  "/download",
  "/contact-us",
];

function ResponsiveAppBar() {
  const accessToken = useSelector((state) => state.user.accessToken);
  const dispatch = useDispatch();

  const handleOpenNewTab = (url) => {
    window.open(url, "_blank", "noopener, noreferrer");
  };

  const renderAuthButton = () => {
    if (accessToken) {
      return (
        <>
          <Button
            sx={{ my: 2, color: "white", display: "block" }}
            onClick={() => navigate("/im")}
            style={{ fontFamily: "gmarketSans", fontSize: "18px" }}
          >
            내 정보
          </Button>
          <Button
            sx={{ my: 2, color: "white", display: "block" }}
            style={{ fontFamily: "gmarketSans", fontSize: "18px" }}
            onClick={() => {
              dispatch(deleteAll());
              axios({
                method: "post",
                url: "https://k9d102.p.ssafy.io/api/ceo/signout",
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
          style={{ fontFamily: "gmarketSans", fontSize: "18px" }}
          onClick={() => navigate("/signin")}
        >
          로그인
        </Button>
      );
    }
  };

  const navigate = useNavigate();
  const handleClick = (index) => {
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
            {pages.map((page) => {
              // 로그인하지 않았고, 페이지가 privatePages에 있는 경우 렌더링하지 않음
              if (!accessToken && privatePages.includes(page)) {
                return null;
              }

              return (
                <Button
                  key={page}
                  sx={{ my: 2, color: "white", display: "block" }}
                  style={{ fontFamily: "gmarketSans", fontSize: "18px" }}
                  onClick={() => {
                    if (
                      pages.indexOf(page) === 1 ||
                      pages.indexOf(page) === 2
                    ) {
                      handleOpenNewTab(url[pages.indexOf(page)]);
                    } else {
                      handleClick(pages.indexOf(page));
                    }
                  }}
                >
                  {page}
                </Button>
              );
            })}

            {renderAuthButton()}
          </Box>
        </Toolbar>
      </Container>
    </AppBar>
  );
}
export default ResponsiveAppBar;
