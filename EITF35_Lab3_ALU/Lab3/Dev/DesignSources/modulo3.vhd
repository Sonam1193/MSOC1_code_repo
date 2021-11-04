-- modulo3 operation
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity modulo3 is 
    generic( const_comparator : integer := 192
                );
	port ( 
			x : in std_logic_vector(7 downto 0) ;
			output : out std_logic_vector(7 downto 0)
			);
end modulo3;

architecture beh of modulo3 is 

	signal x_internal : std_logic_vector(7 downto 0) := (others => '0');
	signal internal_sub_register : std_logic_vector(7 downto 0); -- holds constant 
	signal mux_out : std_logic_vector(7 downto 0) :=(others => '0');               -- will be used as output register
	signal compare_value : integer;
	signal compare_val_uns: unsigned(7 downto 0);

begin
-- sample input number into a register
	x_internal <= x;
	compare_value <= 192;
	internal_sub_register <= std_logic_vector(to_unsigned(compare_value, compare_val_uns'length));
	
	compare: process(x_internal)
	begin
	   if unsigned(x_internal) >= unsigned(internal_sub_register) then
	   mux_out <= std_logic_vector(unsigned(x_internal)- unsigned(internal_sub_register));
	   else
	   mux_out <= std_logic_vector(unsigned(x_internal));
	   end if;
	 
	  end process;

   process(mux_out)
   begin
     output <= mux_out;
   end process;
   
end beh;