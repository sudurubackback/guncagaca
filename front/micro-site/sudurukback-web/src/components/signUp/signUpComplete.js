import * as React from "react";
import Box from "@mui/material/Box";
import CloudUploadIcon from "@mui/icons-material/CloudUpload";
import Grid from "@mui/material/Grid";
import Stepper from "@mui/material/Stepper";
import Step from "@mui/material/Step";
import StepLabel from "@mui/material/StepLabel";
import TextField from "@mui/material/TextField";
import Button from "@mui/material/Button";
import { styled } from "@mui/material/styles";
import styles from "./signUpComplete.module.css";
import Paper from "@mui/material/Paper";
import Stack from "@mui/material/Stack";
import { useNavigate } from "react-router-dom";

//이미지
// import completeImg from "../assets/images/completeImg.png";
import completeImg from "../../assets/images/completeImg.png";
const steps = ["사업자 인증", "회원가입", "완료"];

function SignUpComplete() {
  const navigate = useNavigate();

  const onClickHome = () => {
    //"signup"으로 이동
    navigate("/");
  };
  return (
    <Box sx={{ width: "100%" }}>
      <Box
        sx={{
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          flexWrap: "wrap",
          "& > :not(style)": {
            m: 1,
            width: "50vw",
            height: "50vh",
          },
        }}
        style={{ marginTop: "50px" }}
      >
        <Paper elevation={3}>
          <Stack
            spacing={2}
            direction="column"
            alignItems="center"
            justifyContent="center"
            style={{ height: "100%" }}
          >
            <img
              src={completeImg}
              alt="completeImg"
              className={styles.checkImg}
            />
            <div className={styles.completeText}>
              회원가입 신청이 완료되었습니다.
            </div>
            <Button variant="outlined" onClick={onClickHome}>
              홈으로 돌아가기
            </Button>
          </Stack>
        </Paper>
      </Box>
    </Box>
  );
}
export default SignUpComplete;
