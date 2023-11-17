import * as React from "react";

import Box from "@mui/material/Box";
import Paper from "@mui/material/Paper";
import TextField from "@mui/material/TextField";
import Stack from "@mui/material/Stack";
import Button from "@mui/material/Button";
import styles from "./signIn.module.css";
import axios from "axios";

function FindPw() {
  const [email, setEmail] = React.useState("");
  const [findStatus, setFindStatus] = React.useState(false);

  const handleEmail = (e) => {
    setEmail(e.target.value);
  };

  const onClickFindPw = () => {
    axios({
      method: "post",
      url: "https://k9d102.p.ssafy.io/api/ceo/password",

      data: {
        email: email,
      },
    })
      .then(() => {
        setFindStatus(true);
      })
      .catch(() => {
        alert("존재하지 않는 아이디 입니다.");
      });
  };

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
          <Button
            variant="outlined"
            className={styles.signInBtn}
            style={{
              borderColor: "#9B5748",
              color: "#9B5748",
              widows: "100px",
            }}
            onClick={onClickFindPw}
          >
            비밀번호 초기화
          </Button>
          {findStatus && <div>임시 비밀번호가 이메일로 발송되었습니다.</div>}
        </Stack>
      </Paper>
    </Box>
  );
}

export default FindPw;
