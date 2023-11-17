import * as React from "react";
import { useNavigate } from "react-router-dom";
//css
import styles from "./main.module.css";

//mui
import Button from "@mui/material/Button";
import Grid from "@mui/material/Grid";

//img
import phone from "../assets/images/phone.png";
import intro from "../assets/images/intro_service.png";

function Main() {
  const navigate = useNavigate();

  const onClick = () => {
    //"signup"으로 이동
    navigate("/signup");
  };
  return (
    <div className={styles["container"]}>
      <div>
        <img src={intro} alt="img" className={styles.introImg} />

        <Grid container spacing={2} className={styles.bottom}>
          <Grid item xs={7} className={styles["textBox"]}>
            <div className={styles.titleIntro}>
              근카 가카는 소상공인들의 경쟁력을 <br />
              높이기 위해 제작되었습니다.
            </div>
            <div className={styles["smallIntro"]}>
              인구 100만명 당 커피 점포 수가 미국의 7배 입니다.
              <br />
              이러한 커피 포화 대한민국에서 <br />
              획기적인 솔루션을 제공하고자 합니다.
            </div>
            <Button
              variant="contained"
              size="large"
              style={{
                backgroundColor: "#C19480",
                textAlign: "center",
                fontWeight: "bold",
              }}
              className={styles["button"]}
              onClick={onClick}
            >
              화원가입 하기
            </Button>
          </Grid>

          <Grid item xs>
            <img src={phone} alt="phone" />
          </Grid>
        </Grid>
      </div>
    </div>
  );
}

export default Main;
