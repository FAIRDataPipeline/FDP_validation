library("RSQLite")
library("testthat")

# R implementation --------------------------------------------------------

# Connect to database
file <- "db.sqlite3"
file.exists(file)
con <- dbConnect(drv = RSQLite::SQLite(), dbname = file)

# List all tables
tables <- dbListTables(con)
tables <- tables[-which(tables %in%
                          c("account_emailaddress", "account_emailconfirmation",
                            "auth_group", "auth_group_permissions",
                            "auth_permission", "authtoken_token",
                            "custom_user_user", "custom_user_user_groups",
                            "custom_user_user_user_permissions",
                            "custom_user_user", "django_admin_log",
                            "django_content_type", "django_migrations",
                            "django_session", "django_site",
                            "socialaccount_socialaccount",
                            "socialaccount_socialapp",
                            "socialaccount_socialapp_sites",
                            "socialaccount_socialtoken", "sqlite_sequence"))]

Rdb <- vector("list", length = length(tables))
for (i in seq(along=tables)) {
  Rdb[[i]] <- dbGetQuery(conn = con,
                         statement = paste("SELECT * FROM '",
                                           tables[[i]], "'", sep = ""))
}

# Julia implementation ----------------------------------------------------

# Connect to database
file <- "/Users/runner/.fair/registry/db.sqlite3"
file.exists(file)
con <- dbConnect(drv = RSQLite::SQLite(), dbname = file)

Jdb <- vector("list", length = length(tables))
for (i in seq(along=tables)) {
  Jdb[[i]] <- dbGetQuery(conn = con,
                         statement = paste("SELECT * FROM '",
                                           tables[[i]], "'", sep = ""))
}

context("Testing Julia implementation")

for (i in seq_along(Rdb)) {
  cat("\n",i)
  if (i %in% c(1:3, 8, 14:15, 19:21))
    next
  test_that("entity returns as a named list",{
    r <- Rdb[[i]]
    j <- Jdb[[i]]

    if ("last_updated" %in% colnames(r)) {
      r <- r %>% dplyr::select(-last_updated)
      j <- j %>% dplyr::select(-last_updated)
    }

    if ("uuid" %in% colnames(r)) {
      r <- r %>% dplyr::select(-uuid)
      j <- j %>% dplyr::select(-uuid)
    }

    expect_equal(r, j)
  })
}
