import * as React from "react";
import ImBefore from "../components/im/imBefore";
import ImPort from "../components/im/imPort";
import ImDone from "../components/im/imDone";
import { useSelector } from "react-redux";
import { useDispatch } from "react-redux";
import { setNetworkStatus } from "../store/reducers/user";

function Im() {
  const dispatch = useDispatch();
  const approved = useSelector((state) => state.user.approved);

  const changePortStatus = (newStatus) => {
    dispatch(setNetworkStatus(newStatus));
  };

  const portStatus = useSelector((state) => state.user.netWorkStatus);

  let content;

  if (!approved) {
    content = <ImBefore />;
  } else {
    content = portStatus ? (
      <ImDone />
    ) : (
      <ImPort changePortStatus={changePortStatus} />
    );
  }

  return <div>{content}</div>;
}

export default Im;
