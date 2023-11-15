import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import App from "./App";
import reportWebVitals from "./reportWebVitals";
import { BrowserRouter } from "react-router-dom";
import { Provider } from "react-redux";
import { PersistGate } from "redux-persist/integration/react";
import store from "./store"; // store의 정확한 경로로 수정하세요
import { persistStore } from "redux-persist";

// persistor 인스턴스 생성
let persistor = persistStore(store);

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode>
    <Provider store={store}>
      <PersistGate loading={null} persistor={persistor}>
        {/* <BrowserRouter> */}
        <App />
        {/* </BrowserRouter> */}
      </PersistGate>
    </Provider>
  </React.StrictMode>
);

// 성능 측정을 위한 reportWebVitals 호출
reportWebVitals();
