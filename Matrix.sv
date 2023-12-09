class Matrix #(int m = 3, int n = 3, type T = byte);

  rand T matrix[0:m-1][0:n-1];
  constraint c {foreach (matrix[i, j]) {matrix[i][j] inside {[1:9]};} }

    function new();
                assert (randomize(matrix));
                endfunction


                function void display();
                  for (int i = 0; i < m; i++) begin
                    $write("|");
                    for (int j = 0; j < n; j++) begin
                      $write("%2d",matrix[i][j]); 
                    end
                    $write(" |");$write("\n"); 
                  end $write("\n");
                endfunction
                endclass
                
                