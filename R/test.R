
# https://www.ready.noaa.gov/documents/Tutorial/html/index.html

dispersion_model <-
  create_dispersion_model() %>%
  add_source(
    name = "particle",
    #  lat = 30, lon = 77, height = 50, 
    lat = 31, lon = 75, height = 50, 
    rate = 5, pdiam = 1.1, density = 2, shape_factor = 0.8,
    release_start = lubridate::ymd_hm(date_time),
    release_end = lubridate::ymd_hm(date_time) + lubridate::hours(1)  
    
  ) %>%
  add_dispersion_params(
    start_time = lubridate::ymd_hm(date_time),
    end_time = lubridate::ymd_hm(date_time) + lubridate::hours(60),
    direction = "forward", 
    met_type = "reanalysis",
    met_dir = here::here("met"),
    exec_dir = here::here("out"), 
  ) %>%run_model()



dispersion_model <-
  create_dispersion_model() %>%
  add_source(
    name = "particle",
    lat = 30, lon = 77, height = 1.5, 
    rate = 0.7, pdiam = 1.1, density = 1.5, shape_factor = 0.8,
    release_start = lubridate::ymd_hm("2015-10-01 00:00"),
    release_end = lubridate::ymd_hm("2015-10-01 00:00") + lubridate::hours(1)  
    
  ) %>%
  add_dispersion_params(
    start_time = lubridate::ymd_hm("2015-10-01 00:00"),
    end_time = lubridate::ymd_hm("2015-10-01 00:00") + lubridate::hours(48),
    direction = "forward", 
    met_type = "reanalysis",
    met_dir = 'C:\\Users\\marti\\Dropbox\\research_projects\\try_things_with_splitr/met',
    exec_dir = 'C:\\Users\\marti\\Dropbox\\research_projects\\try_things_with_splitr/out', 
  ) #%>%run_model()


species_list <- 
  dispersion_model$sources[1, ] %>% 
  dplyr::select(-c(lat, lon, height)) %>%
  as.list()



dispersion_model_run <- dispersion_model %>% 
  run_model()



dispersion_tbl <- dispersion_model %>% get_output_tbl()

library(here)

try_something <- hysplit_dispersion(lat = 30, lon = 76, height = 1.5,
                                    start_day = "2015-10-01", start_hour = 0, duration = 2,
                                    direction = "forward", met_type = "reanalysis", vert_motion = 0,
                                    model_height = 20000, particle_num = 100, particle_max = 100,
                                    species = species_list, disp_name = NULL, binary_path = 'C:\\Users\\marti\\Dropbox\\research_projects\\try_things_with_splitr/', 
                                    met_dir = 'C:\\Users\\marti\\Dropbox\\research_projects\\try_things_with_splitr/met', 
                                    exec_dir = 'C:\\Users\\marti\\Dropbox\\research_projects\\try_things_with_splitr/out', clean_up = F, softrun = F)
