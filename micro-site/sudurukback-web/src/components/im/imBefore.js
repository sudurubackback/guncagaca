import * as React from "react";
import Box from "@mui/material/Box";
import Paper from "@mui/material/Paper";
import Grid from "@mui/material/Grid";
import Typography from "@mui/material/Typography";

//이미지
import Logo from "../../assets/images/logo.png";

function ImBefore() {
  return (
    <Box
      sx={{
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        marginTop: "20px",
        flexWrap: "wrap",
        "& > :not(style)": {
          m: 1,
          width: "80vw",
          height: "80vh",
        },
      }}
    >
      <Paper elevation={3} style={{ backgroundColor: "#FFEED4" }}>
        <Grid
          container
          spacing={1}
          style={{ height: "100%", width: "100%" }}
          alignItems="center"
          justifyContent="center"
        >
          <Grid
            item
            xs={6}
            style={{
              display: "flex",
              justifyContent: "center",
              alignItems: "center",
            }}
          >
            <img
              src={Logo}
              alt="logo"
              style={{ width: "60%", overflow: "hidden", maxHeight: "100%" }} // maxHeight를 추가하여 이미지가 Grid 영역을 넘지 않도록 함
            />
          </Grid>
          <Grid
            item
            xs={5}
            style={{
              display: "flex",
              justifyContent: "center",
              alignItems: "center",
            }}
          >
            <Typography style={{ fontWeight: "bolder", fontSize: "49px" }}>
              승인 검토중 입니다.
            </Typography>
          </Grid>
        </Grid>
      </Paper>
    </Box>
  );
}

export default ImBefore;
