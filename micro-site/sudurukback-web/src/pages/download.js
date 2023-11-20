import qr from "../assets/images/qr.png";

function Download() {
  return (
    <div
      style={{
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        marginTop: "5vh",
        height: "60vh",
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
