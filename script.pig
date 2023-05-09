data = LOAD '2016_CvH.csv' USING PigStorage(',') AS (
    game:chararray, white:chararray, black:chararray, white_elo:int, black_elo:int,
    white_rd:int, black_rd:int, white_is_comp:chararray, black_is_comp:chararray,
    time_control:chararray, date:chararray, time:chararray, white_clock:chararray,
    black_clock:chararray, eco:chararray, ply_count:int, result:chararray,
    result_winner:chararray, commentaries:chararray, moves:chararray
);

split_moves = FOREACH data GENERATE FLATTEN(TOKENIZE(moves, ' ')) AS move;

filtered_moves = FILTER split_moves BY SIZE(move) == 2 AND SUBSTRING(move, 0, 1) MATCHES '[a-hA-H]';

grouped_moves = GROUP filtered_moves BY move;
move_counts = FOREACH grouped_moves GENERATE group AS move, COUNT(filtered_moves) AS count;

DUMP move_counts;

