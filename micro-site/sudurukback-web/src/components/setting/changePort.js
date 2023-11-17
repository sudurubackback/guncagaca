import * as React from "react";
import Box from "@mui/material/Box";
import styles from "./changePort.module.css";
import Stack from "@mui/material/Stack";
import TextField from "@mui/material/TextField";
import Button from "@mui/material/Button";
import { Typography } from "@mui/material";
import { useNavigate } from "react-router-dom";
import { useSelector } from "react-redux";
import axios from "axios";

function ChangePort() {
  const accessToken = useSelector((state) => state.user.accessToken);

  const [port, setPort] = React.useState("");
  const [ddns, setDdns] = React.useState("");
  const [ip, setIp] = React.useState("");

  React.useEffect(() => {
    axios({
      method: "get",
      url: "https://k9d102.p.ssafy.io/api/ceo/network",
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    })
      .then((res) => {
        setDdns(res.data.data.ddns);
        setPort(res.data.data.port);
        setIp(res.data.data.ip);
      })
      .catch(() => {});
  }, [accessToken]);

  const navigate = useNavigate();

  const onClickSave = () => {
    axios({
      method: "post",
      url: "https://k9d102.p.ssafy.io/api/ceo/network",
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
      data: {
        ddns: ddns,
        ip: ip,
        port: port,
      },
    })
      .then(() => {
        navigate("/im");
      })
      .catch(() => {});
  };

  const handleCancleClick = () => {
    navigate("/im");
  };

  const handleChangePort = (e) => {
    setPort(e.target.value);
  };

  const handleChangeDdns = (e) => {
    setDdns(e.target.value);
  };

  const handleChangeIp = (e) => {
    setIp(e.target.value);
  };

  return (
    <div className={styles.container}>
      {/* <Box sx={{ width: "30%", alignSelf: "center", margin: "100px" }}> */}
      <Box className={styles.inputContainer}>
        <Stack spacing={3} className={styles.stackContainer}>
          <Typography variant="h6" gutterBottom component="div">
            도메인 주소
          </Typography>
          <TextField
            hiddenLabel
            id="filled-hidden-label-normal"
            value={ddns}
            variant="filled"
            color="warning"
            className={styles.inputArea}
            onChange={handleChangeDdns}
          />
          <Typography variant="h6" gutterBottom component="div">
            포트
          </Typography>
          <TextField
            hiddenLabel
            id="filled-hidden-label-normal"
            value={port}
            variant="filled"
            color="warning"
            className={styles.inputArea}
            onChange={handleChangePort}
          />
          <Typography variant="h6" gutterBottom component="div">
            IP 주소
          </Typography>
          <TextField
            hiddenLabel
            id="filled-hidden-label-normal"
            value={ip}
            variant="filled"
            color="warning"
            className={styles.inputArea}
            onChange={handleChangeIp}
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
              onClick={onClickSave}
            >
              확인
            </Button>
          </Stack>
        </Stack>
      </Box>
    </div>
  );
}

export default ChangePort;
