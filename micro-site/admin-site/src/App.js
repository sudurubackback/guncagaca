import logo from "./logo.svg";
import "./App.css";
import { BrowserRouter, Route, Routes } from "react-router-dom"; // *BrowserRouter를 import

import SignIn from "./pages/signIn";
import BusinessList from "./pages/businessList";

function App() {
  return (
    <BrowserRouter>
      <div className="App">
        {/* main header 위치 */}

        <Routes>
          <Route path="/" element={<SignIn />} />
          <Route path="/list" element={<BusinessList />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
}

export default App;
