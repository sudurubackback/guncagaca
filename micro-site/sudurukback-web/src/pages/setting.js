import * as React from "react";
import { useLocation } from "react-router-dom";

//components
import ChangePort from "../components/setting/changePort";
import ChangePw from "../components/setting/changePw";
import SettingBefore from "../components/setting/settingBefore";

function Setting() {
  const [confirmStatus, setConfirmStatus] = React.useState(false);
  const [password, setPassword] = React.useState("");

  const handleConfirmStatus = () => {
    setConfirmStatus(true);
  };

  const handlePassword = (e) => {
    setPassword(e.target.value);
  };

  const location = useLocation();
  const type = location.state?.type;

  return (
    <div>
      {confirmStatus ? (
        type === "password" ? (
          <ChangePw password={password} />
        ) : (
          <ChangePort />
        )
      ) : (
        <SettingBefore
          handleConfirmStatus={handleConfirmStatus}
          handlePassword={handlePassword}
        />
      )}
    </div>
  );
}

export default Setting;
