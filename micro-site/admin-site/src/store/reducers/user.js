import { createSlice, createAction } from "@reduxjs/toolkit";

export const deleteAll = createAction("user/deleteAll");

const initialState = {
  refreshToken: null,
  accessToken: null,
};

let user = createSlice({
  name: "user",
  initialState: {
    refreshToken: null,
    accessToken: null,
  },
  reducers: {
    setAccessToken: (state, action) => {
      state.accessToken = action.payload;
    },
    setRefreshToken: (state, action) => {
      state.refreshToken = action.payload;
    },
  },
  extraReducers: (builder) => {
    builder.addCase(deleteAll, () => initialState);
  },
  //전체 삭제
});

export const { setAccessToken, setRefreshToken } = user.actions;
export default user.reducer;
