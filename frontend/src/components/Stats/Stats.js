import React, { useState } from "react";
import styled from "styled-components";
import Paper from "@material-ui/core/Paper";
import { useQuery } from "@apollo/react-hooks";
import { GET_PLAYERS } from "../../queries/player";
import { StatsTableHead } from "./StatsTableHead";
import Table from "@material-ui/core/Table";
import TableBody from "@material-ui/core/TableBody";
import TableCell from "@material-ui/core/TableCell";
import TableContainer from "@material-ui/core/TableContainer";
import TableRow from "@material-ui/core/TableRow";

export const Stats = () => {
  const { loading, error, data, refetch } = useQuery(GET_PLAYERS);
  const [order, setOrder] = useState("asc");
  const [orderBy, setOrderBy] = useState("rushingAttempts");

  const handleRequestSort = (_, property) => {
    const isAsc = orderBy === property && order === "asc";
    setOrder(isAsc ? "desc" : "asc");
    setOrderBy(property);
  };

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;
  console.log(data);
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
            <TableBody>
              {data.players.map((row, index) => {
                return (
                  <TableRow hover key={row.name}>
                    <TableCell
                      component="th"
                      id={`tr-${index}`}
                      scope="row"
                      padding="none"
                    >
                      {row.name}
                    </TableCell>
                    <TableCell>{row.team}</TableCell>
                    <TableCell>{row.position}</TableCell>
                    <TableCell>{row.stats.rushingAttempts}</TableCell>
                    <TableCell>{row.stats.rushingAttemptsPerGame}</TableCell>
                    <TableCell>{row.stats.totalRushingYards}</TableCell>
                    <TableCell>{row.stats.rushingYardsPerAttempt}</TableCell>
                    <TableCell>{row.stats.rushingYardsPerGame}</TableCell>
                    <TableCell>{row.stats.totalRushingTouchdowns}</TableCell>
                    <TableCell>{row.stats.longestRush}</TableCell>
                    <TableCell>{row.stats.rushingFirstDowns}</TableCell>
                    <TableCell>{row.stats.rushingFirstDownPct}</TableCell>
                    <TableCell>{row.stats.rushing20Plus}</TableCell>
                    <TableCell>{row.stats.rushing40Plus}</TableCell>
                    <TableCell>{row.stats.rushingFumbles}</TableCell>
                  </TableRow>
                );
              })}
            </TableBody>
          </Table>
        </TableContainer>
      </Paper>
    </Wrapper>
  );
};

const Wrapper = styled.div`
  color: blue;
`;
