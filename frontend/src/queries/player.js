import { gql } from "apollo-boost";

export const GET_PLAYERS = gql`
  query($sortBy: SortBy, $nameFilter: String, $limit: Int, $offset: Int) {
    players(
      sortBy: $sortBy
      nameFilter: $nameFilter
      limit: $limit
      offset: $offset
    ) {
      totalCount
      nodes {
        id
        name
        team
        position
        stats {
          rushingAttempts
          rushingAttemptsPerGame
          totalRushingYards
          rushingYardsPerAttempt
          rushingYardsPerGame
          totalRushingTouchdowns
          longestRush
          rushingFirstDowns
          rushingFirstDownPct
          rushing20Plus
          rushing40Plus
          rushingFumbles
        }
      }
    }
  }
`;
