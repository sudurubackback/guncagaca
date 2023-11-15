import * as React from "react";
import axios from "axios";

//mui

import Box from "@mui/material/Box";
import CloudUploadIcon from "@mui/icons-material/CloudUpload";
import Grid from "@mui/material/Grid";
import Stepper from "@mui/material/Stepper";
import Step from "@mui/material/Step";
import StepLabel from "@mui/material/StepLabel";
import TextField from "@mui/material/TextField";
import Button from "@mui/material/Button";
import { styled } from "@mui/material/styles";

const VisuallyHiddenInput = styled("input")({
  clip: "rect(0 0 0 0)",
  clipPath: "inset(50%)",
  height: 1,
  overflow: "hidden",
  position: "absolute",
  bottom: 0,
  left: 0,
  whiteSpace: "nowrap",
  width: 1,
});

function Business({ handleNext, handleBusinessId }) {
  const [business_name, setBusiness_name] = React.useState("");
  const [address, setAddress] = React.useState("");
  const [business_number, setBusiness_number] = React.useState("");
  const [owner_name, setOwner_name] = React.useState("");
  const [open_date, setOpen_date] = React.useState("");
  const [account_number, setAccount_number] = React.useState("");
  const [tel, setTel] = React.useState("");

  const [file, setFile] = React.useState(null);

  const handleBusinessName = (e) => {
    setBusiness_name(e.target.value);
  };

  const handleAddress = (e) => {
    setAddress(e.target.value);
  };

  const handleBusinessNumber = (e) => {
    setBusiness_number(e.target.value);
  };

  const handleOwnerName = (e) => {
    setOwner_name(e.target.value);
  };

  const handleOpenDate = (e) => {
    setOpen_date(e.target.value);
  };

  const handleAccountNumber = (e) => {
    setAccount_number(e.target.value);
  };

  const handleTel = (e) => {
    setTel(e.target.value);
  };

  const onclickCheckBusiness = () => {
    const formData = new FormData();
    formData.append("file", file);
    const data = {
      business_name: business_name,
      address: address,
      business_number: business_number,
      owner_name: owner_name,
      open_date: open_date,
      account_number: account_number,
      tel: tel,
    };

    formData.append("file", file);
    formData.append(
      "reqDto",
      new Blob([JSON.stringify(data)], {
        type: "application/json",
      })
    );

    axios({
      method: "post",
      url: "https://k9d102.p.ssafy.io/api/ceo/cert",
      data: formData,
    })
      .then((res) => {
        handleBusinessId(res.data.data.business_id);
        handleNext();
      })
      .catch(() => {
        alert("사업자 인증에 실패하였습니다.");
        handleNext();
      });
  };

  const handleFile = (e) => {
    setFile(e.target.files[0]);
  };

  return (
    <div>
      <Box sx={{ flexGrow: 1 }}>
        <Grid container spacing={2}>
          <Grid item xs={6} md={8}>
            <Box
              display="flex"
              flexDirection="column"
              alignItems="center"
              width="60%"
              marginLeft={30}
              marginTop={5}
            >
              <TextField
                id="outlined-basic"
                label="상호"
                variant="outlined"
                margin="normal"
                fullWidth
                onChange={handleBusinessName}
              />
              <TextField
                id="outlined-basic"
                label="사업장 주소"
                variant="outlined"
                margin="normal"
                fullWidth
                onChange={handleAddress}
              />
              <TextField
                id="outlined-basic"
                label="사업자등록번호"
                variant="outlined"
                margin="normal"
                fullWidth
                onChange={handleBusinessNumber}
              />
              <TextField
                id="outlined-basic"
                label="대표자성명"
                variant="outlined"
                margin="normal"
                fullWidth
                onChange={handleOwnerName}
              />
              <TextField
                id="outlined-basic"
                label="개업일자"
                placeholder="YYYYMMDD"
                variant="outlined"
                margin="normal"
                fullWidth
                onChange={handleOpenDate}
              />
              <TextField
                id="outlined-basic"
                label="정산 계좌번호"
                variant="outlined"
                placeholder="OO은행 123456789"
                margin="normal"
                fullWidth
                onChange={handleAccountNumber}
              />
              <TextField
                id="outlined-basic"
                label="사업장 전화번호"
                variant="outlined"
                placeholder="010-1234-1234"
                margin="normal"
                fullWidth
                onChange={handleTel}
              />
            </Box>
          </Grid>
          <Grid item xs={6} md={4}>
            <Box
              display="flex"
              flexDirection="column"
              alignItems="center"
              width="60%"
              marginRight={30}
              marginTop={10}
              alignContent="center"
              justifyContent="center"
              height="50vh"
            >
              <Button
                component="label"
                variant="contained"
                startIcon={<CloudUploadIcon />}
                style={{
                  marginTop: "20px",
                  backgroundColor: "#FFB549",
                  color: "white",
                  width: "100%",
                  height: "80px",
                }}
              >
                Upload file
                <VisuallyHiddenInput type="file" onChange={handleFile} />
              </Button>
              <div style={{ marginTop: "10px" }}>
                파일 명 : 상호명_사업자등록번호
              </div>
              <Button
                variant="outlined"
                size="large"
                style={{ marginTop: "50px" }}
                onClick={onclickCheckBusiness}
              >
                사업자 인증 하기
              </Button>
            </Box>
          </Grid>
        </Grid>
      </Box>
    </div>
  );
}
export default Business;
