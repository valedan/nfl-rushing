import React, { useState } from "react";
import styled from "styled-components";
import Paper from "@material-ui/core/Paper";
import { useQuery } from "@apollo/react-hooks";
import { GET_PLAYERS } from "../../queries/player";
import { StatsTableHead } from "./StatsTableHead";
import { StatsTableBody } from "./StatsTableBody";
import Table from "@material-ui/core/Table";
import TableContainer from "@material-ui/core/TableContainer";

export const Stats = () => {
  const [order, setOrder] = useState("DESC");
  const [orderBy, setOrderBy] = useState("rushingAttempts");
  const { loading, error, data, refetch } = useQuery(GET_PLAYERS, {
    variables: { sortBy: { field: orderBy, order } }
  });

  const handleRequestSort = (_, property) => {
    const isDesc = orderBy === property && order === "DESC";
    setOrder(isDesc ? "ASC" : "DESC");
    setOrderBy(property);
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
            <StatsTableBody data={data} />
          </Table>
        </TableContainer>
      </Paper>
    </Wrapper>
  );
};

const Wrapper = styled.div`
  color: blue;
`;
