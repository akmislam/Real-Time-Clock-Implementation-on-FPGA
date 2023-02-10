-------------------------------------------------------------------------------
--
-- Title       : rtc_parallel_load
-- Design      : Task3
-- Author      : Akm Islam
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : E:\ESE382\Lab11\Task 3\Task3\Task3\src\rtc_parallel_load.vhd
-- Generated   : Sun Apr 25 19:11:32 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is a design description for an interface with a
--				 microcontroller compatible parallel bus. It generates address,
--				 data, and WR_n and RD_n control strobes.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_Std.all;

library Task4;
use Task4.all;

entity rtc_parallel_load is
	port(
		rst_n : in std_logic; 				-- active low synchronous reset
		clk : in std_logic; 				-- system clock
		clr_n : in std_logic; 				-- active low synchronous clear
		address : in std_logic_vector(3 downto 0);
		data : in std_logic_vector(7 downto 0);
		wr_n : in std_logic; 				-- write control signal
		cs_n : in std_logic; 				-- chip select signal
		cnt_en_1 : in std_logic;			-- enable count 1
		max_count : out std_logic;
		count_sec : out std_logic_vector(6 downto 0);	-- BCD sec count
		count_min : out std_logic_vector(6 downto 0);	-- BCD min count
		count_hour : out std_logic_vector(5 downto 0)	-- BCD hour count
	);
end rtc_parallel_load;

architecture structure of rtc_parallel_load is
-- local signal declarations
signal run_clock_chain, a_pe_to_wr, s_to_y4, r_to_y0: std_logic;
signal y1_to_loadsec, y2_to_loadmin, y3_to_loadhour: std_logic;
signal y5to9: std_logic_vector(4 downto 0);
begin
	u5: entity pos_edge_detector port map (a => wr_n, rst_n => rst_n, clk => clk, a_pe => a_pe_to_wr);
	u6:	entity write_address_decoder port map (cs_n => cs_n, address => address, wr => a_pe_to_wr, y(0) => r_to_y0, y(1) => y1_to_loadsec, y(2) => y2_to_loadmin, y(3) => y3_to_loadhour, y(4) => s_to_y4, y(9 downto 5) => y5to9); 
	u7: entity s_r_flip_flop port map (clk => clk, rst_n => rst_n, q => run_clock_chain, s => s_to_y4, r => r_to_y0);
	u8: entity clock_chain port map (rst_n => rst_n, clk => clk, clr_n => clr_n, setting_sec => data(6 downto 0), setting_min => data(6 downto 0), setting_hour => data(5 downto 0), cnt_en_1 => cnt_en_1, cnt_en_2 => run_clock_chain, max_count => max_count, count_sec => count_sec, count_min => count_min, count_hour => count_hour, load_sec_en => y1_to_loadsec, load_min_en => y2_to_loadmin, load_hour_en => y3_to_loadhour);
		
end structure;
