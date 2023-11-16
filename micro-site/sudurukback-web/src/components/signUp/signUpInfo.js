import * as React from "react";
import Box from "@mui/material/Box";
import Grid from "@mui/material/Grid";
import TextField from "@mui/material/TextField";
import Button from "@mui/material/Button";
import styles from "./signUpInfo.module.css";
import axios from "axios";

//components
import Timer from "./timer";

function SignUpInfo({ handleNext, businessId }) {
  const [sendStatus, setSendStatus] = React.useState(false);
  const [emailStatus, setEmailStatus] = React.useState(false);
  const [emailCodeStatus, setEmailCodeStatus] = React.useState(false);
  const [passwordStatus, setPasswordStatus] = React.useState(false);
  const [tel, setTel] = React.useState("");

  const [email, setEmail] = React.useState("");
  const [emailCode, setEmailCode] = React.useState("");
  const [password, setPassword] = React.useState("");
  const [passwordConfirm, setPasswordConfirm] = React.useState("");

  const handleTimerEnd = () => {
    setSendStatus(false);
  };

  //인증번호 전송 버튼 클릭 리스너

  const hadleEmailCheckOnClick = () => {
    axios({
      method: "post",
      url: "https://k9d102.p.ssafy.io/api/ceo/checkemail",
      data: {
        email: email,
      },
    })
      .then(() => {
        setEmailStatus(true);
        alert("사용 가능한 이메일입니다.");
      })
      .catch(() => {
        alert("유효하지 않은 이메일입니다.");
      });
  };

  const onClickEmailSend = () => {
    axios({
      method: "post",
      url: "https://k9d102.p.ssafy.io/api/ceo/code",
      data: {
        email: email,
      },
    })
      .then(() => {
        setSendStatus(true);
      })
      .catch(() => {
        setSendStatus(true);
      });
  };

  //인증 코드 확인
  const handleEmailCode = (e) => {
    setEmailCode(e.target.value);
  };
  const onClickCheckEmailCode = () => {
    axios({
      method: "post",
      url: "https://k9d102.p.ssafy.io/api/ceo/checkcode",
      data: {
        email: email,
        code: emailCode,
      },
    })
      .then(() => {
        setEmailCodeStatus(true);
        alert("인증번호 확인 성공");
      })
      .catch(() => {
        alert("인증번호 확인 실패");
      });
  };

  //비밀번호
  const handlePassword = (e) => {
    setPassword(e.target.value);
  };

  //비밀번호 확인
  const handlePasswordConfirm = (e) => {
    setPasswordConfirm(e.target.value);
  };

  const handlePasswordConfirmChange = (e) => {
    handlePasswordConfirm(e);
    handlePasswordStatus(e.target.value);
  };

  const handlePasswordStatus = (confirmValue) => {
    setPasswordStatus(password === confirmValue);
  };

  const handleTel = (e) => {
    setTel(e.target.value);
  };

  const onClickSignUp = () => {
    axios({
      method: "post",
      url: "https://k9d102.p.ssafy.io/api/ceo/signup",
      data: {
        email: email,
        password: password,
        tel: tel,
        business_id: businessId,
      },
    })
      .then(() => {
        alert("회원가입 성공");
        handleNext();
      })
      .catch(() => {
        alert("회원가입 실패");
      });
  };

  return (
    <div>
      <div className={styles.container}>
        <Box sx={{ flexGrow: 2 }}>
          {/* <Grid container spacing={8} className={styles.emailContainer}> */}
          <Grid container spacing={4} alignItems="flex-end">
            {/* 이메일 입력*/}
            <Grid item xs={12} md={7}>
              <TextField
                id="email"
                label="이메일"
                variant="outlined"
                fullWidth
                onChange={(e) => setEmail(e.target.value)}
              />
            </Grid>
            <Grid item xs={12} md={2}>
              <Button
                variant="contained"
                className={styles.button}
                style={{ backgroundColor: "#9B5748" }}
                onClick={hadleEmailCheckOnClick}
              >
                이메일 중복 확인
              </Button>
            </Grid>
            {/* 이메일 인증 코드 전송*/}
            <Grid item xs={12} md={7}>
              <TextField
                id="email"
                label="이메일 인증 코드"
                variant="outlined"
                fullWidth
                onChange={handleEmailCode}
              />
            </Grid>
            <Grid item xs={12} md={2}>
              {emailStatus ? (
                sendStatus ? (
                  <Button
                    variant="contained"
                    className={styles.button}
                    style={{ backgroundColor: "#9B5748" }}
                    onClick={onClickCheckEmailCode}
                  >
                    인증코드 확인
                  </Button>
                ) : (
                  <Button
                    variant="contained"
                    className={styles.button}
                    style={{ backgroundColor: "#9B5748" }}
                    onClick={onClickEmailSend}
                  >
                    인증코드 전송
                  </Button>
                )
              ) : null}
              {sendStatus && !emailCodeStatus && (
                <Timer onTimerEnd={handleTimerEnd} />
              )}
            </Grid>
            {/*전화번호 입력*/}
            <Grid item xs={12} md={7}>
              <TextField
                id="tel"
                label="전화번호"
                variant="outlined"
                fullWidth
                placeholder="010-1234-1234"
                onChange={handleTel}
              />
            </Grid>

            {/* 비밀번호 입력 */}
            <Grid item xs={12} md={7}>
              <TextField
                id="email"
                label="비밀번호"
                variant="outlined"
                onChange={handlePassword}
                fullWidth
                type="password"
              />
            </Grid>
            {/* 비밀번호 확인 */}
            <Grid item xs={12} md={7}>
              <TextField
                id="email"
                label="비밀번호 확인"
                variant="outlined"
                fullWidth
                onChange={handlePasswordConfirmChange}
                type="password"
              />

              {password !== "" &&
                passwordConfirm !== "" &&
                (password === passwordConfirm ? (
                  <p style={{ color: "green" }}>비밀번호가 일치합니다.</p>
                ) : (
                  <p style={{ color: "red" }}>비밀번호가 일치하지 않습니다.</p>
                ))}
            </Grid>
          </Grid>
          {emailCodeStatus && passwordStatus && tel !== "" ? (
            <Button
              variant="contained"
              className={styles.submitBtn}
              style={{ backgroundColor: "#9B5748", fontSize: "1.5rem" }}
              onClick={onClickSignUp}
            >
              회원가입 신청
            </Button>
          ) : null}
        </Box>
      </div>
    </div>
  );
}

export default SignUpInfo;
