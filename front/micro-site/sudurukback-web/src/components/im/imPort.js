import * as React from "react";
import { useNavigate } from "react-router-dom";
import Box from "@mui/material/Box";
import Paper from "@mui/material/Paper";
import Grid from "@mui/material/Grid";
import Typography from "@mui/material/Typography";
import Stack from "@mui/material/Stack";
import TextField from "@mui/material/TextField";
import Button from "@mui/material/Button";

import styles from "./imPort.module.css";
import axios from "axios";

import { useDispatch } from "react-redux";

import { setNetworkStatus } from "../../store/reducers/user";
import { useSelector } from "react-redux";

function ImPort({ changePortStatus }) {
  const accessToken = useSelector((state) => state.user.accessToken);

  const dispatch = useDispatch();

  // const [ddns, setDdns] = React.useState("");
  const [ip, setIp] = React.useState("");
  const [port, setPort] = React.useState("");

  // const handleDdns = (e) => {
  //   setDdns(e.target.value);
  // };

  const handleIp = (e) => {
    setIp(e.target.value);
  };

  const onClickSave = () => {
    //redux에 저장
    axios({
      method: "post",
      url: "https://k9d102.p.ssafy.io/api/ceo/network",
      // url: "http://localhost:9999/api/ceo/port",
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
      data: {
        // ddns: ddns,
        ip: ip,
        port: port,
      },
    })
      .then(() => {
        changePortStatus(true);
        dispatch(setNetworkStatus(true));
      })
      .catch((err) => {
        console.log();
        console.log(err);
      });
  };

  return (
    <Box
      className={styles.box}
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
          {/* <TextField
            id="ddns"
            label="DDNS 주소"
            variant="filled"
            style={{ color: "#9B5748" }}
            onChange={handleDdns}
          /> */}
          <TextField
            id="ip"
            label="IP 번호"
            variant="filled"
            borderColor="#9B5748"
            onChange={handleIp}
          />
          <TextField
            id="ip"
            label="Port 번호"
            variant="filled"
            borderColor="#9B5748"
            onChange={(e) => setPort(e.target.value)}
          />
        </Stack>
        <div className={styles.btnContainer}>
          <Button
            variant="outlined"
            className={styles.signInBtn}
            style={{ borderColor: "#9B5748", color: "#9B5748" }}
            fullWidth
            onClick={onClickSave}
          >
            저장
          </Button>
        </div>
      </Paper>
    </Box>
  );
}

export default ImPort;
