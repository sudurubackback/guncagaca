import React from "react";
import Paper from "@mui/material/Paper";
import Grid from "@mui/material/Grid";

import styles from "./contactUs.module.css";

import ming from "../assets/images/ming.jpg";
import kim from "../assets/images/kim.png";
import choi from "../assets/images/choi.jpg";
import kwon from "../assets/images/kwon.jpg";
import two from "../assets/images/2.jpg";
import eunjin from "../assets/images/eunjin.jpg";

const ContactUs = () => {
  //모든 이미지들을 배열로 관리
  const images = [ming, kim, choi, kwon, two, eunjin];
  const names = ["강민승", "김제준", "촤영태", "권민재", "이기표", "서은진"];

  return (
    <div className={styles["container"]}>
      <div className={styles["intro_container"]}>
        <Grid sx={{ flexGrow: 1 }} container spacing={5}>
          <Grid item xs={12}>
            <Grid container justifyContent="center" spacing={12}>
              {[0, 1, 2].map((value) => (
                <Grid key={value} item>
                  <Paper
                    sx={{
                      height: 250,
                      width: 250,
                      overflow: "hidden",
                    }}
                  >
                    <img
                      src={images[value]}
                      alt="Your Description"
                      style={{
                        width: "100%",
                        height: "100%",
                        objectFit: "cover",
                      }}
                    />
                  </Paper>
                  <h4>{names[value]}</h4>
                </Grid>
              ))}
            </Grid>
          </Grid>
        </Grid>
      </div>
      <div>
        <Grid sx={{ flexGrow: 1 }} container spacing={5}>
          <Grid item xs={12}>
            <Grid container justifyContent="center" spacing={12}>
              {[0, 1, 2].map((value) => (
                <Grid key={value} item>
                  <Paper
                    sx={{
                      height: 250,
                      width: 250,
                      overflow: "hidden",
                    }}
                  >
                    <img
                      src={images[value + 3]}
                      alt="Your Description"
                      style={{
                        width: "100%",
                        height: "100%",
                        objectFit: "cover",
                      }}
                    />
                  </Paper>
                  <h4>{names[value + 3]}</h4>
                </Grid>
              ))}
            </Grid>
          </Grid>
        </Grid>
      </div>
    </div>
  );
};
export default ContactUs;
