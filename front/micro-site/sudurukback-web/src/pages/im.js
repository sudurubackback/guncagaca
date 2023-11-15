import * as React from "react";
import ImBefore from "../components/im/imBefore";
import ImPort from "../components/im/imPort";
import ImDone from "../components/im/imDone";
import { useEffect } from "react";
import { useSelector } from "react-redux";
import { useDispatch } from "react-redux";
import { setNetworkStatus } from "../store/reducers/user";

function Im() {
  // redux에서 approved 값을 가져옵니다.
  const dispatch = useDispatch();
  const approved = useSelector((state) => state.user.approved);

  const changePortStatus = (newStatus) => {
    dispatch(setNetworkStatus(newStatus));
  };

  //redux의 port, ip, ddns값이 null이면 portStatus를 false로 변경합니다.

  const portStatus = useSelector((state) => state.user.netWorkStatus);

  // value와 portStatus 값에 따라 렌더링할 컴포넌트를 결정합니다.
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
