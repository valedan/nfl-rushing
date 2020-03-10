import React from "react";
import styled from "styled-components";
import Toolbar from "@material-ui/core/Toolbar";
import TextField from "@material-ui/core/TextField";
import InputAdornment from "@material-ui/core/InputAdornment";
import IconButton from "@material-ui/core/IconButton";
import ClearIcon from "@material-ui/icons/Clear";
import GetAppIcon from "@material-ui/icons/GetApp";

export const StatsTableToolbar = ({ nameFilter, handleChangeName }) => {
  return (
    <Toolbar>
      <TextField
        variant="outlined"
        value={nameFilter}
        placeholder="Player name..."
        size="small"
        onChange={event => handleChangeName(event.target.value)}
        InputProps={{
          endAdornment: (
            <InputAdornment position="end">
              <IconButton onClick={() => handleChangeName("")}>
                {<ClearIcon />}
              </IconButton>
            </InputAdornment>
          )
        }}
      />
      <form method="post" action="/players/export">
        <input hidden type="text" name="order" value={order} />
        <input hidden type="text" name="orderBy" value={orderBy} />
        <input hidden type="text" name="nameFilter" value={nameInput} />

        <IconButton type="submit">{<GetAppIcon />}</IconButton>
      </form>
    </Toolbar>
  );
};
