import "./App.css";
import { BrowserRouter, Route, Routes } from "react-router-dom"; // *BrowserRouter를 import

import ResponsiveAppBar from "./components/responsiveAppBar.js";
import ContactUs from "./pages/contactUs.js";
import Main from "./pages/main.js";
import SignUp from "./pages/signUp.js";
import SignIn from "./pages/signIn.js";
import Im from "./pages/im.js";
import FindPw from "./pages/findPw.js";
import Setting from "./pages/setting.js";

function App() {
  return (
    <BrowserRouter>
      <div className="App">
        {/* main header 위치 */}
        <div>
          <ResponsiveAppBar />
        </div>

        <Routes>
          <Route path="/" element={<Main />} />
          <Route path="/im" element={<Im />}></Route>
          <Route path="/signup" element={<SignUp />}></Route>
          <Route path="/contact-us" element={<ContactUs />} />
          <Route path="/signin" element={<SignIn />} />
          <Route path="/findpw" element={<FindPw />} />
          <Route path="/im/setting" element={<Setting />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
}

export default App;
