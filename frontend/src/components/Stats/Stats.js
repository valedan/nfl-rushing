import React, { useState, useEffect } from "react";
import styled from "styled-components";
import Paper from "@material-ui/core/Paper";
import { useQuery } from "@apollo/react-hooks";
import { GET_PLAYERS } from "../../queries/player";
import { StatsTableHead } from "./StatsTableHead";
import { StatsTableBody } from "./StatsTableBody";
import TablePagination from "@material-ui/core/TablePagination";
import Table from "@material-ui/core/Table";
import Toolbar from "@material-ui/core/Toolbar";
import TextField from "@material-ui/core/TextField";
import CircularProgress from "@material-ui/core/CircularProgress";
import InputAdornment from "@material-ui/core/InputAdornment";
import IconButton from "@material-ui/core/IconButton";
import TableContainer from "@material-ui/core/TableContainer";
import ClearIcon from "@material-ui/icons/Clear";
import GetAppIcon from "@material-ui/icons/GetApp";

export const Stats = () => {
  const [order, setOrder] = useState("DESC");
  const [orderBy, setOrderBy] = useState("rushingAttempts");
  const [nameInput, setNameInput] = useState("");
  const [page, setPage] = useState(0);
  const rowsPerPage = 10;
  const { loading, error, data } = useQuery(GET_PLAYERS, {
    variables: {
      sortBy: { field: orderBy, order },
      limit: rowsPerPage,
      offset: page * rowsPerPage,
      nameFilter: nameInput
    }
  });

  const handleRequestSort = (_, property) => {
    const isDesc = orderBy === property && order === "DESC";
    setOrder(isDesc ? "ASC" : "DESC");
    setOrderBy(property);
    setPage(0);
  };

  const handleChangePage = (_, newPage) => {
    setPage(newPage);
  };

  const handleNameChange = event => {
    setNameInput(event.target.value);
  };

  const tableContent = () => {
    if (loading) {
      return <CircularProgress />;
    } else if (error) {
      return <p>Error :(</p>;
    } else {
      return (
        <Table size="medium">
          <StatsTableHead
            order={order}
            orderBy={orderBy}
            onRequestSort={handleRequestSort}
          />
          <StatsTableBody data={data.players.nodes} />
        </Table>
      );
    }
  };

  const clearFilter = () => {
    setNameInput("");
  };

  return (
    <Wrapper>
      <Paper>
        <TableContainer>
          <Toolbar>
            <TextField
              variant="outlined"
              value={nameInput}
              placeholder="Player name..."
              size="small"
              onChange={handleNameChange}
              InputProps={{
                endAdornment: (
                  <InputAdornment position="end">
                    <IconButton onClick={clearFilter}>
                      {<ClearIcon />}
                    </IconButton>
                  </InputAdornment>
                )
              }}
            />
            <form method="post" action="/players/export">
              <input hidden type="text" name="order" value={order} />
              <input hidden type="text" name="orderBy" value={orderBy} />
              <input hidden type="text" name="nameInput" value={nameInput} />

              <IconButton type="submit">{<GetAppIcon />}</IconButton>
            </form>
          </Toolbar>
          {tableContent()}
          {/* TODO: Use a custom actions component to add first/last page buttons */}
          <TablePagination
            rowsPerPageOptions={[rowsPerPage]}
            component="div"
            count={data && data.players.totalCount}
            rowsPerPage={rowsPerPage}
            page={page}
            onChangePage={handleChangePage}
          />
        </TableContainer>
      </Paper>
    </Wrapper>
  );
};

const Wrapper = styled.div`
  color: blue;
`;
