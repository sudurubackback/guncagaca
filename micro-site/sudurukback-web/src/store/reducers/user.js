import { createSlice, createAction } from "@reduxjs/toolkit";

export const deleteAll = createAction("user/deleteAll");

const initialState = {
  refreshToken: null,
  accessToken: null,
  approved: false,
  netWorkStatus: false,
};

let user = createSlice({
  name: "user",
  initialState: {
    refreshToken: null,
    accessToken: null,
    approved: false,
    netWorkStatus: false,
  },
  reducers: {
    setAccessToken: (state, action) => {
      state.accessToken = action.payload;
    },
    setRefreshToken: (state, action) => {
      state.refreshToken = action.payload;
    },
    setApproved: (state, action) => {
      state.approved = action.payload;
    },
    setNetworkStatus: (state, action) => {
      state.netWorkStatus = action.payload;
    },
  },
  extraReducers: (builder) => {
    builder.addCase(deleteAll, () => initialState);
  },
  //전체 삭제
});

export const {
  setAccessToken,
  setRefreshToken,
  setApproved,
  setNetworkStatus,
} = user.actions;
export default user.reducer;
