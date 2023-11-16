import * as React from "react";
import Box from "@mui/material/Box";
import styles from "./changePw.module.css";
import Stack from "@mui/material/Stack";
import TextField from "@mui/material/TextField";
import Button from "@mui/material/Button";
import axios from "axios";
import { useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";

function ChangePw({ password }) {
  const navigate = useNavigate();
  const accessToken = useSelector((state) => state.user.accessToken);
  const [newPassword, setNewPassword] = React.useState("");
  const [passwordConfirm, setPasswordConfirm] = React.useState("");
  //비밀번호 입력 받음
  const handlePassword = (e) => {
    setNewPassword(e.target.value);
  };

  //비밀번호 확인 입력 받음
  const handlePasswordConfirm = (e) => {
    setPasswordConfirm(e.target.value);
  };

  const handleSubmit = (e) => {
    console.log(password);
    if (newPassword === passwordConfirm) {
      //비밀번호 변경
      axios({
        method: "put",
        url: "https://k9d102.p.ssafy.io/api/ceo/password",
        headers: {
          Authorization: `Bearer ${accessToken}`,
        },
        data: {
          password: password,
          newPassword: newPassword,
        },
      })
        .then(() => {
          alert("비밀번호가 변경되었습니다.");
          navigate("/im");
        })
        .catch((err) => {
          console.log(err);
        });
    } else {
      alert("비밀번호가 일치하지 않습니다.");
    }
  };

  return (
    <div className={styles.container}>
      <Box sx={{ flexGrow: 1 }} className={styles.boxContainer}>
        <Stack spacing={5}>
          <TextField
            label="새 비밀번호"
            type="password"
            color="warning"
            focused
            onChange={handlePassword}
          />
          <TextField
            label="새 비밀번호 확인"
            type="password"
            color="warning"
            focused
            onChange={handlePasswordConfirm}
          />
          {newPassword && passwordConfirm && newPassword !== passwordConfirm ? (
            <p style={{ color: "red" }}>비밀번호가 일치하지 않습니다.</p>
          ) : (
            <p />
          )}

          <Stack direction="row" spacing={3} className={styles.btnContainer}>
            <Button className={styles.cancleBtn} variant="outlined">
              취소
            </Button>
            <Button
              className={styles.changeBtn}
              variant="contained"
              onClick={handleSubmit}
            >
              확인
            </Button>
          </Stack>
        </Stack>
      </Box>
    </div>
  );
}

export default ChangePw;
