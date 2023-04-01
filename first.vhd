library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;
use     ieee.std_logic_misc.all;
use     ieee.numeric_std.all;

entity TOP is
    generic(
        constant N          : integer := 10
    );
    port(
        clk: in bit;
        btn: in bit_vector (3 downto 0);
        je: out bit_vector(7 downto 0)
    );
end TOP;

architecture  behavioral of TOP is
   signal Y: bit_vector(7 downto 0);
   signal On_Off_flag: bit:='0';
   signal Speed_flag: bit:='0';
   signal Schemat: bit:='0';
   signal Speed: natural:=124;
   signal Counter: natural:=0;
   signal UP_DOWN: bit:='0';
   signal BTN_1, BTN_2, BTN_3: bit;
   signal BTN_1_delay, BTN_2_delay, BTN_3_delay: bit;
   signal CLK_PRESCALER: bit;
   signal CLK_PRESCALER_DB: bit;
   
begin
    
    DEB1_inst: entity work.debouncer(behavioral)
    port map (
        clk => CLK_PRESCALER_DB,
        input_btn => btn(1),
        output_btn => BTN_1
    );
    
    DEB2_inst: entity work.debouncer(behavioral)
    port map (
        clk => CLK_PRESCALER_DB,
        input_btn => btn(2),
        output_btn => BTN_2
    );
    
    DEB3_inst: entity work.debouncer(behavioral)
    port map (
        clk => CLK_PRESCALER_DB,
        input_btn => btn(3),
        output_btn => BTN_3
    );
    
    
    PreS_inst: entity work.prescaler(behavioral)
    port map (
        clk => clk,
        speed => Speed,
        out_clk => CLK_PRESCALER
    );
    
    PreS_inst1: entity work.prescaler(behavioral)
    port map (
        clk => clk,
        speed => 15,
        out_clk => CLK_PRESCALER_DB
    );
    
    process(clk) is
    begin
        if(clk' event and clk='1') then
            if (CLK_PRESCALER='1') then
if(On_Off_flag = '0') then
                if(Schemat = '0') then
                -- obsluga diod Schemat 1 swiecenia Diod
                    Y <= not Y;
                else
                -- obsluga diod Schemat 2 swiecenia Diod
                    if(UP_DOWN = '0') then
                        if(Counter < 7) then
                            Counter <= Counter + 1;
                        else
                            UP_DOWN <= not UP_DOWN;
                            Counter <= Counter - 1;
                        end if;
                    else
                        if(Counter > 0) then
                            Counter <= Counter - 1;
                        else
                            UP_DOWN <= not UP_DOWN;
                            Counter <= Counter + 1;
                        end if;
                    end if;
                end if;
            else
                Y <= "00000000";
            end if;
            
            if(Schemat = '1') then
                if (Counter = 0) then
                    Y <= "00000001";
                elsif (Counter = 1) then
                    Y <= "00000010";
                elsif (Counter = 2) then
                    Y <= "00000100";
                elsif (Counter = 3) then
                    Y <= "00001000";
                elsif (Counter = 4) then
                    Y <= "00010000";
                elsif (Counter = 5) then
                    Y <= "00100000";
                elsif (Counter = 6) then
                    Y <= "01000000";
                elsif (Counter = 7) then
                    Y <= "10000000";
                else
                    Y <= "00000000";
                end if;
            end if;
            
            end if;
        end if;

    end process;

    process(clk) is
    begin 
        if(clk' event and clk='1') then
                
--            -- obsluga guzika----------------------------------------------------
            if(On_Off_flag = '0') then
                    if(BTN_1 = '1' and BTN_1_delay = '0') then
                        BTN_1_delay <= '1';
                        On_Off_flag <= '1';
                    end if;
            else
                    if(BTN_1 = '1' and BTN_1_delay = '0') then
                        BTN_1_delay <= '1';
                        On_Off_flag <= '0';
                    end if; 
            end if;
            
            if(BTN_1_delay = '1' and BTN_1 = '0') then
                BTN_1_delay <= '0';
            end if;
            
--            -------------------------------------------------------------------------------
            
            -- obsluga predkosci swiecenia -----------------------------
            if(BTN_2 = '1' and BTN_2_delay = '0') then
                if(Speed_flag = '1') then
                    Speed <= 64;
                    Speed_flag <= '0';
                else
                    Speed <= 124;
                    Speed_flag <= '1';
                end if;
                BTN_2_delay <= '1';
            end if;
            

            
            if(BTN_2_delay = '1' and BTN_2 = '0') then
                BTN_2_delay <= '0';
            end if;
--            ----------------------------------------------------------------
            
--            -- obsluga schematu swiecenia-----------------------------------------
            if(Schemat = '0') then
                if(BTN_3 = '1' and BTN_3_delay = '0') then
                    Schemat <= '1';
                end if;
            else
                if(BTN_3 = '1' and BTN_3_delay = '0') then
                    Schemat <= '0';
                end if; 
            end if;
            
            if(BTN_3_delay = '1' and BTN_3 = '0') then
                BTN_3_delay <= '0';
            end if;
        end if;
    end process;

    je <= Y;
end behavioral;

