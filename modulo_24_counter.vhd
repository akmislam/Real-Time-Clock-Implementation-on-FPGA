-------------------------------------------------------------------------------
--
-- Title       : modulo_24_counter
-- Design      : Task1
-- Author      : Akm Islam
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : E:\ESE382\Lab11\Task 1\Task1\Task1\src\modulo_24_counter.vhd
-- Generated   : Sun Apr 25 15:06:34 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is a design description for a modulo 24 counter. This
--				 functions the same as the modulo 60 counter, but counts from
--				 0 to 23, then rolls over. 
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity modulo_24_counter is
port(
	rst_n :	in std_logic; 					-- active low synchronous reset
	clk : in std_logic; 						-- system clock
	clr_n : in std_logic; 					-- active low synchronous clear
	load_en : in std_logic; 					-- parallel load counter
	setting : in std_logic_vector(5 downto 0); 	-- load value 
	cnt_en_1 : in std_logic; 					-- enable count 1
	cnt_en_2 : in std_logic; 					-- enable count 2
	max_count : out std_logic; 					-- maximum count flag
	count : out std_logic_vector(5 downto 0) 	-- BCD count
);
end modulo_24_counter;

--architecture behavior of modulo_24_counter is
--begin
--	counter_24: process (clk)
--	variable bcd0: integer := 0;	-- one's place variable
--	variable bcd1: integer := 0;    -- ten's place variable
--	begin 
--		if rising_edge(clk) then 	-- synchronous counter
--			
--			-- if rst_n is asserted
--			if rst_n = '0' then
--				max_count <= '0';	-- max count reinitialized
--				count <= "000000";	-- count is set to all 0's
--				bcd0 := 0;
--				bcd1 := 0;
--			
--			-- if clr_n is asserted
--			elsif clr_n = '0' then
--				max_count <= '0';	-- max count reinitialized
--				count <= "000000";	-- count is set to all 0's
--				bcd0 := 0;
--				bcd1 := 0;
--				
--			-- if load_en is asserted
--			elsif load_en = '1' then
--				count <= setting;	-- parallel load settings out 
--				bcd0 := to_integer(unsigned(setting(3 downto 0)));
--				bcd1 := to_integer(unsigned(setting(5 downto 4)));  
--
--			-- if cnt_en_1 is asserted
--			elsif cnt_en_1 = '1' then
--		-- comment this in for Bryant's method.
--		--	elsif cnt_en_1 = '1' and cnt_en_2 = '1' then
--				if (bcd1 = 2) and (bcd0 = 2) then -- if count is 22
--					max_count <= '1';			  -- set max count
--					bcd1 := 2;
--					bcd0 := 3;	
--					
--				elsif (bcd1 = 2) and (bcd0 = 3) then -- if count is 23
--					bcd1 := 0;						 -- clear max count
--					bcd0 := 0;
--					max_count <= '0';
--					
--				elsif bcd0 < 9 then				-- if position 0 is under 9
--					bcd0 := bcd0 + 1;  
--					max_count <= '0';
--					
--				elsif bcd0 = 9 then				-- is position 0 is 9  
--					-- comment this out for Bryant's method.
--					if cnt_en_2 = '1' then		-- increment position 1 
--						bcd1 := bcd1 + 1;
--						bcd0 := 0;
--					end if;
--					max_count <= '0';
--					
--				end if;
--
--			end if;	  
--
--		end if;
--		count <= std_logic_vector(to_unsigned(bcd1, 2)) & std_logic_vector(to_unsigned(bcd0, 4));	-- count gets the count
--	end process;
--
--
--end behavior;



architecture behavior of modulo_24_counter is
begin
	counter_24: process (clk)
	variable bcd0: integer := 0;	-- one's place variable
	variable bcd1: integer := 0;    -- ten's place variable
	begin 
		if rising_edge(clk) then 	-- synchronous counter
			
			-- if rst_n is asserted
			if rst_n = '0' then
				max_count <= '0';	-- max count reinitialized
				count <= "000000";	-- count is set to all 0's
				bcd0 := 0;
				bcd1 := 0;
			
			-- if clr_n is asserted
			elsif clr_n = '0' then
				max_count <= '0';	-- max count reinitialized
				count <= "000000";	-- count is set to all 0's
				bcd0 := 0;
				bcd1 := 0;
				
			-- if load_en is asserted
			elsif load_en = '1' then
				count <= setting;	-- parallel load settings out 
				bcd0 := to_integer(unsigned(setting(3 downto 0)));
				bcd1 := to_integer(unsigned(setting(5 downto 4)));
				
				if bcd1 = 2 and bcd0 = 3 then
					max_count <= '1';
				end if;

			-- if cnt_en_1 is asserted
		--	elsif cnt_en_1 = '1' then
		-- comment this in for Bryant's method.
			elsif cnt_en_1 = '1' and cnt_en_2 = '1' then
				if (bcd1 = 2) and (bcd0 = 2) then -- if count is 22
					max_count <= '1';			  -- set max count
					bcd1 := 2;
					bcd0 := 3;	
					
				elsif (bcd1 = 2) and (bcd0 = 3) then -- if count is 23
					bcd1 := 0;						 -- clear max count
					bcd0 := 0;
					max_count <= '0';
					
				elsif bcd0 < 9 then				-- if position 0 is under 9
					bcd0 := bcd0 + 1;  
					max_count <= '0';
					
				elsif bcd0 = 9 then				-- is position 0 is 9  
					-- comment this out for Bryant's method.
				--	if cnt_en_2 = '1' then		-- increment position 1 
						bcd1 := bcd1 + 1;
						bcd0 := 0;
				--	end if;
					max_count <= '0';
					
				end if;

			end if;	  

		end if;
		count <= std_logic_vector(to_unsigned(bcd1, 2)) & std_logic_vector(to_unsigned(bcd0, 4));	-- count gets the count
	end process;


end behavior;
