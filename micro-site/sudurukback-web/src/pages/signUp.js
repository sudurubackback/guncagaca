import * as React from "react";

import Business from "../components/signUp/business.js";
import SignUpInfo from "../components/signUp/signUpInfo.js";
import SignUpComplete from "../components/signUp/signUpComplete.js";
import Stepper from "@mui/material/Stepper";
import Step from "@mui/material/Step";
import StepLabel from "@mui/material/StepLabel";
import Box from "@mui/material/Box";

const steps = ["사업자 인증", "회원가입", "완료"];

function SignUp() {
  const [business_id, setBusinessId] = React.useState("1");
  const [activeStep, setActiveStep] = React.useState(0);

  const handleBusinessId = (businessId) => {
    setBusinessId(businessId);
  };
  const handleNext = () => {
    setActiveStep((prevActiveStep) => prevActiveStep + 1);
  };

  const handleBack = () => {
    setActiveStep((prevActiveStep) => prevActiveStep - 1);
  };

  const handleReset = () => {
    setActiveStep(0);
  };

  const getStepContent = (step) => {
    <Box sx={{ width: "100%" }}>
      <Stepper activeStep={0} alternativeLabel style={{ marginTop: "30px" }}>
        {steps.map((label) => (
          <Step key={label}>
            <StepLabel>{label}</StepLabel>
          </Step>
        ))}
      </Stepper>
    </Box>;
    switch (step) {
      case 0:
        return (
          <Business
            handleNext={handleNext}
            handleBusinessId={handleBusinessId}
          />
        );
      case 1:
        return (
          <SignUpInfo
            handleNext={handleNext}
            handleBack={handleBack}
            businessId={business_id}
          />
        );
      case 2:
        return <SignUpComplete handleReset={handleReset} />;
      default:
        return "Unknown step";
    }
  };

  return (
    <div>
      <Box sx={{ width: "100%", marginBottom: "-50px" }}>
        <Stepper
          activeStep={activeStep}
          alternativeLabel
          style={{ marginTop: "30px" }}
        >
          {steps.map((label) => (
            <Step key={label}>
              <StepLabel>{label}</StepLabel>
            </Step>
          ))}
        </Stepper>
      </Box>
      {getStepContent(activeStep)}
    </div>
  );
}

export default SignUp;
