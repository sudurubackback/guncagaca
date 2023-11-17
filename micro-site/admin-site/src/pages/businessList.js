import React, { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";

import Paper from "@mui/material/Paper";
import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TablePagination from "@mui/material/TablePagination";
import TableRow from "@mui/material/TableRow";

const columns = [
  { id: "name", label: "가게 명", minWidth: 170 },
  { id: "businessNumber", label: "사업자 번호", minWidth: 100 },
  {
    id: "ownerName",
    label: "대표자 성명",
    minWidth: 170,
    align: "right",
  },
  {
    id: "isApproved",
    label: "승인 여부",
    minWidth: 170,
    align: "right",
  },
];

const rows = [
  {
    name: "가게1",
    businessNumber: "123-45-67890",
    ownerName: "홍길동",
    isApproved: "승인",
  },
  {
    name: "가게2",
    businessNumber: "123-45-67890",
    ownerName: "홍길동",
    isApproved: "승인",
  },
];

function BusinessList() {
  const navigate = useNavigate();
  const accessToken = useSelector((state) => state.user.accessToken);

  useEffect(() => {
    if (!accessToken) {
      navigate("/");
    }
  }, [accessToken, navigate]);

  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(+event.target.value);
    setPage(0);
  };

  return (
    <Paper sx={{ width: "100%" }}>
      <TableContainer sx={{ maxHeight: 440 }}>
        <Table stickyHeader aria-label="sticky table">
          <TableHead>
            <TableRow>
              {columns.map((column) => (
                <TableCell
                  key={column.id}
                  align={column.align}
                  style={{ minWidth: column.minWidth }}
                >
                  {column.label}
                </TableCell>
              ))}
            </TableRow>
          </TableHead>
          <TableBody>
            {rows
              .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
              .map((row, index) => {
                return (
                  <TableRow hover role="checkbox" tabIndex={-1} key={index}>
                    {columns.map((column) => {
                      const value = row[column.id];
                      return (
                        <TableCell key={column.id} align={column.align}>
                          {value}
                        </TableCell>
                      );
                    })}
                  </TableRow>
                );
              })}
          </TableBody>
        </Table>
      </TableContainer>
      <TablePagination
        rowsPerPageOptions={[10, 25, 100]}
        component="div"
        count={rows.length}
        rowsPerPage={rowsPerPage}
        page={page}
        onPageChange={handleChangePage}
        onRowsPerPageChange={handleChangeRowsPerPage}
      />
    </Paper>
  );
}

export default BusinessList;
