import qr from "../assets/images/qr.jpeg";

function Download() {
  return (
    <div
      style={{
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        height: "100vh",
      }}
    >
      <img
        src={qr}
        alt="download"
        style={{ maxWidth: "100%", maxHeight: "100%" }}
      />
    </div>
  );
}

export default Download;
