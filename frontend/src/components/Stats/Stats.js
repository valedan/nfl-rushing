import React, { useState } from "react";
import styled from "styled-components";
import Paper from "@material-ui/core/Paper";
import { useQuery } from "@apollo/react-hooks";
import { GET_PLAYERS } from "../../queries/player";
import { StatsTableHead } from "./StatsTableHead";
import { StatsTableBody } from "./StatsTableBody";
import TablePagination from "@material-ui/core/TablePagination";
import Table from "@material-ui/core/Table";
import TableContainer from "@material-ui/core/TableContainer";

export const Stats = () => {
  const [order, setOrder] = useState("DESC");
  const [orderBy, setOrderBy] = useState("rushingAttempts");
  const [page, setPage] = useState(0);
  const rowsPerPage = 15;
  const { loading, error, data } = useQuery(GET_PLAYERS, {
    variables: {
      sortBy: { field: orderBy, order },
      limit: rowsPerPage,
      offset: page * rowsPerPage
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

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;
  return (
    <Wrapper>
      <Paper>
        <TableContainer>
          <Table size="medium">
            <StatsTableHead
              order={order}
              orderBy={orderBy}
              onRequestSort={handleRequestSort}
            />
            <StatsTableBody data={data.players.nodes} />
          </Table>
          {/* TODO: Use a custom actions component to add first/last page buttons */}
          <TablePagination
            rowsPerPageOptions={[rowsPerPage]}
            component="div"
            count={data.players.totalCount}
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
