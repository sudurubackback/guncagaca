import * as React from "react";
import Box from "@mui/material/Box";
import TextField from "@mui/material/TextField";
import styles from "./settingBefore.module.css";
import Stack from "@mui/material/Stack";
import Button from "@mui/material/Button";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import { useSelector } from "react-redux";

function SettingBefore({ handleConfirmStatus, handlePassword }) {
  const accessToken = useSelector((state) => state.user.accessToken);
  const navigate = useNavigate();
  const [password, setPassword] = React.useState("");

  const handleCancleClick = () => {
    navigate("/im");
  };

  const onClickConfirm = () => {
    axios({
      method: "post",
      url: "https://k9d102.p.ssafy.io/api/ceo/auth",
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
      data: {
        password: password,
      },
    })
      .then(() => {
        handleConfirmStatus();
      })
      .catch(() => {
        alert("비밀번호가 일치하지 않습니다.");
      });
  };

  const handlePasswordInput = (e) => {
    setPassword(e.target.value);
    handlePassword(e);
  };

  return (
    <div className={styles.container}>
      <Box className={styles.inputContainer}>
        <Stack spacing={5}>
          <TextField
            id="filled-basic"
            label="비밀번호"
            variant="filled"
            color="warning"
            type="password"
            onChange={handlePasswordInput}
            className={styles.inputArea}
          />

          <Stack direction="row" spacing={2}>
            <Button
              className={styles.cancleBtn}
              variant="outlined"
              onClick={handleCancleClick}
            >
              취소
            </Button>
            <Button
              className={styles.changeBtn}
              variant="contained"
              onClick={onClickConfirm}
            >
              확인
            </Button>
          </Stack>
        </Stack>
      </Box>
    </div>
  );
}

export default SettingBefore;
