import * as React from "react";
import { useNavigate } from "react-router-dom";
import { useDispatch } from "react-redux";
//mui
import Box from "@mui/material/Box";
import Paper from "@mui/material/Paper";
import TextField from "@mui/material/TextField";
import Stack from "@mui/material/Stack";
import Button from "@mui/material/Button";
import { Link } from "react-router-dom";
//css
import styles from "./signIn.module.css";
import axios from "axios";
import {
  setAccessToken,
  setRefreshToken,
  setApproved,
  setNetworkStatus,
} from "../store/reducers/user";

function SignIn() {
  const dispatch = useDispatch();
  const [signInStatus, setSignInStatus] = React.useState(false);

  const [email, setEmail] = React.useState("");
  const [password, setPassword] = React.useState("");

  const handleEmail = (e) => {
    setEmail(e.target.value);
  };

  const handlePassword = (e) => {
    setPassword(e.target.value);
  };

  const navigate = useNavigate();

  const onClickSignIn = () => {
    axios({
      method: "post",
      url: "https://k9d102.p.ssafy.io/api/ceo/signin",
      data: {
        email: email,
        password: password,
      },
    })
      .then((res) => {
        dispatch(setAccessToken(res.data.data.accessToken));
        dispatch(setRefreshToken(res.data.data.refreshToken));
        dispatch(setNetworkStatus(res.data.data.setNetwork));
        dispatch(setApproved(res.data.data.approved));
        setSignInStatus(true);
      })
      .catch(() => {
        alert("아이디 혹은 비밀번호를 확인해주세요.");
      });
  };

  const onClickSignUp = () => {
    navigate("/signup");
  };

  React.useEffect(() => {
    if (signInStatus) {
      navigate("/im");
    }
  }, [navigate, signInStatus]);

  return (
    <Box
      sx={{
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        height: "80vh",
        width: "100vw",
      }}
    >
      <Paper
        elevation={3}
        sx={{
          m: 1,
          width: "50vw",
          height: "60vh",
        }}
        style={{ backgroundColor: "#F6F4F1" }}
        className={styles.container}
      >
        <Stack spacing={5} className={styles.textField}>
          <TextField
            id="email"
            label="이메일"
            variant="filled"
            style={{ color: "#9B5748" }}
            onChange={handleEmail}
          />
          <TextField
            id="password"
            label="비밀번호"
            variant="filled"
            borderColor="#9B5748"
            type="password"
            onChange={handlePassword}
          />
        </Stack>
        <div className={styles.btnContainer}>
          <Button
            variant="outlined"
            className={styles.signInBtn}
            style={{ borderColor: "#9B5748", color: "#9B5748" }}
            onClick={onClickSignUp}
          >
            회원가입
          </Button>
          <Button
            variant="contained"
            className={styles.signInBtn}
            style={{ backgroundColor: "#9B5748" }}
            onClick={onClickSignIn}
          >
            로그인
          </Button>
        </div>
        <div className={styles.linkContainer}>
          <Link to="/findpw" style={{ color: "#9B5748" }}>
            비밀번호를 잊으셨나요?
          </Link>
        </div>
      </Paper>
    </Box>
  );
}

export default SignIn;
