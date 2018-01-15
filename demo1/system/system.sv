module system
  (
   input              clk,
   input [7:0]        in,
   output logic [7:0] out
   );

   {% for c in chain %}
     logic [7:0] chain{{ loop.index0 }};
   {% endfor %}

   {% for c in chain %}
     {% if loop.index0 == 0 %}
       {{ c }} u_chain{{ loop.index0 }}(.in(in),.out(chain{{ loop.index0 }}));
     {% else %}
       {{ c }} u_chain{{ loop.index0 }}(.in(chain{{ loop.index0 - 1 }}),.out(chain{{ loop.index0 }}));
     {% endif %}
   {% endfor %}

   {% if outputreg %}
     always @(posedge clk) out <= chain{{ chain|length - 1 }};
   {% else %}
     assign out <= chain[{{ chain|length - 1 }}];
   {% endif %}
endmodule // system
