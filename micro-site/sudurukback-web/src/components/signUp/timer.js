import React, { useEffect, useState } from "react";

export default function Timer({ onTimerEnd }) {
  // 시간을 담을 변수
  const [count, setCount] = useState(300);

  useEffect(() => {
    if (count === 0) {
      onTimerEnd(); // Call the callback function when the timer ends
      return;
    }

    const id = setInterval(() => {
      setCount((prevCount) => prevCount - 1);
    }, 1000);

    return () => clearInterval(id);
  }, [count, onTimerEnd]);

  const minutes = Math.floor(count / 60);
  const seconds = count % 60;

  return (
    <p style={{ margin: 0, color: "red" }}>{`${minutes}:${seconds
      .toString()
      .padStart(2, "0")}`}</p>
  );
}
