import React, { useEffect, useState } from "react";
import { styled } from "@mui/material/styles";
import { useSelector } from "react-redux";
import Box from "@mui/material/Box";
import Paper from "@mui/material/Paper";
import Grid from "@mui/material/Grid";
import styles from "./imDone.module.css";
import Stack from "@mui/material/Stack";
import Button from "@mui/material/Button";
import InputLabel from "@mui/material/InputLabel";
import MenuItem from "@mui/material/MenuItem";
import FormControl from "@mui/material/FormControl";
import Select from "@mui/material/Select";
import CloudUploadIcon from "@mui/icons-material/CloudUpload";

import { useNavigate } from "react-router-dom";

import defaultImg from "../../assets/images/defaultStoreImg.png";
import { TextField, Typography } from "@mui/material";

import axios from "axios";

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

const hourItem = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
const miniteItem = [0, 10, 20, 30, 40, 50];
const timeType = ["오전", "오후"];

function ImDone() {
  const navigate = useNavigate();

  const [description, setDescription] = React.useState("");
  const [img, setImg] = React.useState(defaultImg);
  const [openHour, setOpenHour] = React.useState(1);
  const [openMinute, setOpenMinute] = React.useState(0);
  const [openTimeType, setOpenTimeType] = React.useState("");

  const [closeHour, setCloseHour] = React.useState(1);
  const [closeMinute, setCloseMinute] = React.useState(0);
  const [closeTimeType, setCloseTimeType] = React.useState("");

  const [tel, setTel] = React.useState("");

  const accessToken = useSelector((state) => state.user.accessToken);

  function parseTime(timeString) {
    const [time, meridiem] = timeString.split(" ");
    const [hour, minute] = time.split(":").map(Number);
    return { hour, minute, meridiem };
  }

  useEffect(() => {
    axios({
      method: "get",
      url: "https://k9d102.p.ssafy.io/api/cafe/info",
      // url: "http://localhost:9999/api/ceo/info",
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    }).then((res) => {
      console.log(res.data.data);
      setTel(res.data.data.tel);
      setDescription(res.data.data.description);
      const openTimeData = parseTime(res.data.data.openTime);
      const closeTimeData = parseTime(res.data.data.closeTime);

      setOpenHour(openTimeData.hour);
      setOpenMinute(openTimeData.minute);
      setOpenTimeType(openTimeData.meridiem);

      setCloseHour(closeTimeData.hour);
      setCloseMinute(closeTimeData.minute);
      setCloseTimeType(closeTimeData.meridiem);

      setImg(res.data.data.img);
    });
  }, [navigate]);

  const handleImg = (e) => {
    setImg(e.target.files[0]);
  };
  const [openTime, setOpenTime] = React.useState(
    `${openHour}:${openMinute} ${openTimeType}`
  );

  React.useEffect(() => {
    setOpenTime(`${openHour}:${openMinute} ${openTimeType}`);
    setCloseTime(`${closeHour}:${closeMinute} ${closeTimeType}`);

    console.log(openTime);
    console.log(closeTime);
  }, [
    closeHour,
    closeMinute,
    closeTimeType,
    openHour,
    openMinute,
    openTimeType,
  ]);

  const [closeTime, setCloseTime] = React.useState(
    `${closeHour}:${closeMinute} ${closeTimeType}`
  );

  const handleTel = (event) => {
    setTel(event.target.value);
  };

  const handleOpenHourChange = (event) => {
    setOpenHour(event.target.value);
  };

  const handleOpenMinuteChange = (event) => {
    setOpenMinute(event.target.value);
  };

  const handleOpenTimeTypeChange = (event) => {
    setOpenTimeType(event.target.value);
  };

  const handleCloseHourChange = (event) => {
    setCloseHour(event.target.value);
  };

  const handleCloseMinuteChange = (event) => {
    setCloseMinute(event.target.value);
  };

  const handleCloseTimeTypeChange = (event) => {
    setCloseTimeType(event.target.value);
  };

  const handleDescription = (event) => {
    setDescription(event.target.value);
  };

  const handlePasswordClick = () => {
    navigate("/im/setting", { state: { type: "password" } });
  };

  const handlePortClick = () => {
    navigate("/im/setting", { state: { type: "port" } });
  };

  const onClickSave = () => {
    const formData = new FormData();

    console.log(img);

    const data = {
      description: description,
      openTime: openTime,
      closeTime: closeTime,
      tel: tel,
    };
    formData.append("file", img);
    formData.append(
      "reqDto",
      new Blob([JSON.stringify(data)], {
        type: "application/json",
      })
    );

    axios({
      method: "put",
      url: "https://k9d102.p.ssafy.io/api/cafe/info",
      data: formData,
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    })
      .then(() => {
        alert("수정 완료");
        window.location.reload();
      })
      .catch((err) => {
        console.log(err);
        alert("수정 실패. 다시 시도해주세요.");
      });
  };

  return (
    <div className={styles.container}>
      <Grid container spacing={7}>
        <Grid item xs={5}>
          <Stack spacing={7} className={styles.leftContainer}>
            {img ? (
              <img src={img} className={styles.img} alt="Uploaded" />
            ) : (
              <img src={defaultImg} className={styles.img} alt="Default" />
            )}

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
              사진 등록
              <VisuallyHiddenInput type="file" onChange={handleImg} />
            </Button>
          </Stack>
        </Grid>
        <Grid item xs={7}>
          <Stack spacing={3} className={styles.rightContainer}>
            <Stack direction="row" spacing={2}>
              <Button
                className={styles.privateBtn}
                variant="contained"
                onClick={handlePasswordClick}
              >
                비밀번호 변경
              </Button>
              <Button
                className={styles.privateBtn}
                variant="contained"
                onClick={handlePortClick}
              >
                포트 변경
              </Button>
            </Stack>
            <textarea
              id="filled-multiline-static"
              label="가게 설명"
              multiline
              rows={4}
              defaultValue={description}
              placeholder="가게 설명을 입력해주세요."
              variant="filled"
              fullWidth
              onChange={handleDescription}
              className={styles.description}
            />
            <Stack direction="row" spacing={2}>
              {/* 오픈 시간 */}
              <Typography className={styles.timeText}>오픈 시간</Typography>
              <FormControl className={styles.selectBox}>
                <InputLabel id="demo-simple-select-label">시</InputLabel>
                <Select
                  labelId="demo-simple-select-label"
                  id="demo-simple-select"
                  value={openHour}
                  label="시"
                  onChange={handleOpenHourChange}
                >
                  {hourItem.map((item) => (
                    <MenuItem value={item}>{item}</MenuItem>
                  ))}
                </Select>
              </FormControl>

              {/* 오픈 분 */}
              <FormControl className={styles.selectBox}>
                <InputLabel id="demo-simple-select-label">분</InputLabel>
                <Select
                  labelId="demo-simple-select-label"
                  id="demo-simple-select"
                  value={openMinute}
                  label="분"
                  onChange={handleOpenMinuteChange}
                >
                  {miniteItem.map((item) => (
                    <MenuItem value={item}>{item}</MenuItem>
                  ))}
                </Select>
              </FormControl>

              {/* 오픈 시간 타입 */}
              <FormControl className={styles.selectBox}>
                <InputLabel id="demo-simple-select-label">타입</InputLabel>
                <Select
                  labelId="demo-simple-select-label"
                  id="demo-simple-select"
                  value={openTimeType}
                  label="타입"
                  onChange={handleOpenTimeTypeChange}
                >
                  {timeType.map((item) => (
                    <MenuItem value={item}>{item}</MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Stack>

            {/* 마감 시간 */}

            <Stack direction="row" spacing={2}>
              <Typography className={styles.timeText}>마감 시간</Typography>
              <FormControl className={styles.selectBox}>
                <InputLabel id="demo-simple-select-label">시</InputLabel>
                <Select
                  labelId="demo-simple-select-label"
                  id="demo-simple-select"
                  value={closeHour}
                  label="시"
                  onChange={handleCloseHourChange}
                >
                  {hourItem.map((item) => (
                    <MenuItem value={item}>{item}</MenuItem>
                  ))}
                </Select>
              </FormControl>

              {/* 마감 분 */}
              <FormControl className={styles.selectBox}>
                <InputLabel id="demo-simple-select-label">분</InputLabel>
                <Select
                  labelId="demo-simple-select-label"
                  id="demo-simple-select"
                  value={closeMinute}
                  label="분"
                  onChange={handleCloseMinuteChange}
                >
                  {miniteItem.map((item) => (
                    <MenuItem value={item}>{item}</MenuItem>
                  ))}
                </Select>
              </FormControl>

              {/* 마감 시간 타입 */}
              <FormControl className={styles.selectBox}>
                <InputLabel id="demo-simple-select-label">타입</InputLabel>
                <Select
                  labelId="demo-simple-select-label"
                  id="demo-simple-select"
                  value={closeTimeType}
                  label="타입"
                  onChange={handleCloseTimeTypeChange}
                >
                  {timeType.map((item) => (
                    <MenuItem value={item}>{item}</MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Stack>
            <Stack direction="row" spacing={2}>
              <Typography className={styles.timeText}>전화번호</Typography>
              <TextField
                hiddenLabel
                id="filled-hidden-label-normal"
                variant="outlined"
                color="warning"
                value={tel}
                onChange={handleTel}
                className={styles.inputArea}
              />
            </Stack>

            {/* 수정 완료 버튼 */}
            <Stack direction="row" spacing={2}>
              <Button className={styles.cancleBtn} variant="outlined">
                취소
              </Button>
              <Button
                className={styles.changeBtn}
                variant="contained"
                onClick={onClickSave}
              >
                수정
              </Button>
            </Stack>
          </Stack>
        </Grid>
      </Grid>
    </div>
  );
}

export default ImDone;
