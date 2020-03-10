import React, { useState } from "react";
import styled from "styled-components";
import Paper from "@material-ui/core/Paper";
import { useQuery } from "@apollo/react-hooks";
import { GET_PLAYERS } from "../../queries/player";
import { StatsTableHead } from "./StatsTableHead";
import { StatsTableBody } from "./StatsTableBody";
import { StatsTableToolbar } from "./StatsTableToolbar";
import TablePagination from "@material-ui/core/TablePagination";
import Table from "@material-ui/core/Table";
import TableContainer from "@material-ui/core/TableContainer";

export const Stats = () => {
  const [order, setOrder] = useState("DESC");
  const [orderBy, setOrderBy] = useState("rushingAttempts");
  const [nameFilter, setNameFilter] = useState("");
  const [page, setPage] = useState(0);
  const rowsPerPage = 10;
  const { loading, error, data } = useQuery(GET_PLAYERS, {
    variables: {
      sortBy: { field: orderBy, order },
      limit: rowsPerPage,
      offset: page * rowsPerPage,
      nameFilter
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

  const handleChangeName = newFilter => {
    setNameFilter(newFilter);
  };

  return (
    <Wrapper>
      <Paper elevation={4}>
        <TableContainer>
          <StatsTableToolbar
            nameFilter={nameFilter}
            handleChangeName={handleChangeName}
            order={order}
            orderBy={orderBy}
          />
          <Table size="medium">
            <StatsTableHead
              order={order}
              orderBy={orderBy}
              onRequestSort={handleRequestSort}
            />
            <StatsTableBody data={data} loading={loading} error={error} />
          </Table>
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
  width: 95%;
  margin: auto;
  margin-top: 4%;
`;
