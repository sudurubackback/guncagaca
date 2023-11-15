import * as React from "react";
import Box from "@mui/material/Box";
import TextField from "@mui/material/TextField";
import Stack from "@mui/material/Stack";
import styles from "./signIn.module.css";
import Button from "@mui/material/Button";

import { useDispatch } from "react-redux";
import { setAccessToken, setRefreshToken } from "../store/reducers/user";
import { useNavigate } from "react-router-dom";

function SignIn() {
  const navigate = useNavigate();
  const dispatch = useDispatch();

  const [email, setEmail] = React.useState("");
  const [password, setPassword] = React.useState("");

  const handleEmailChange = (e) => {
    setEmail(e.target.value);
  };

  const handlePasswordChange = (e) => {
    setPassword(e.target.value); // password state 업데이트
  };

  const onClickSignIn = () => {
    console.log("email: ", email);
    dispatch(setAccessToken("accessToken"));
    dispatch(setRefreshToken("refreshToken"));
    navigate("/list");
  };

  return (
    <div>
      <h1> 로그인 </h1>
      <Box
        component="form"
        sx={{
          "& > :not(style)": { m: 1, width: "25ch" },
        }}
        noValidate
        autoComplete="off"
        className={styles.inputContainer}
      >
        <Stack spacing={2}>
          <TextField
            id="filled-basic"
            label="email"
            variant="filled"
            color="warning"
            className={styles.input}
            onChange={handleEmailChange}
          />
          <TextField
            id="filled-basic"
            label="password"
            variant="filled"
            color="warning"
            className={styles.input}
            onChange={handlePasswordChange}
          />

          <Button variant="contained" color="warning" onClick={onClickSignIn}>
            로그인
          </Button>
        </Stack>
      </Box>
    </div>
  );
}

export default SignIn;
