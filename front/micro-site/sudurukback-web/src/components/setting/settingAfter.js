import * as React from "react";
import Box from "@mui/material/Box";
import Drawer from "@mui/material/Drawer";
import AppBar from "@mui/material/AppBar";
import CssBaseline from "@mui/material/CssBaseline";
import Toolbar from "@mui/material/Toolbar";
import List from "@mui/material/List";
import Typography from "@mui/material/Typography";
import Divider from "@mui/material/Divider";
import ListItem from "@mui/material/ListItem";
import ListItemButton from "@mui/material/ListItemButton";
import ListItemIcon from "@mui/material/ListItemIcon";
import ListItemText from "@mui/material/ListItemText";
import InboxIcon from "@mui/icons-material/MoveToInbox";
import MailIcon from "@mui/icons-material/Mail";
import PasswordIcon from "@mui/icons-material/Password";
import LanIcon from "@mui/icons-material/Lan";
import { styled } from "@mui/material/styles";
import styles from "./settingAfter.module.css";

const drawerWidth = 200;

const settingItems = ["비밀번호 설정", "포트 설정"];
const settingIcons = [<PasswordIcon />, <LanIcon />];

function SettingAfter() {
  return <div className={styles.container}></div>;
}

export default SettingAfter;
