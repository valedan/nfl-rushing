import React from "react";
import styled from "styled-components";
import TableCell from "@material-ui/core/TableCell";
import TableRow from "@material-ui/core/TableRow";
import TableBody from "@material-ui/core/TableBody";
import CircularProgress from "@material-ui/core/CircularProgress";

export const StatsTableBody = ({ data, loading, error }) => {
  const tableContent = () => {
    if (loading) {
      return <CircularProgress />;
    } else if (error) {
      return <p>Error :(</p>;
    } else {
      return data.players.nodes.map(row => {
        return (
          <TableRow key={row.name}>
            <TableCell>{row.name}</TableCell>
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
      });
    }
  };

  return <TableBody>{tableContent()}</TableBody>;
};
