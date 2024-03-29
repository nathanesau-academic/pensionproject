gain_loss1 <- data.frame(
  category=c("Initial" ,"Interest", "Investment",
             "Service", "Payment",
             "Salary", "Retire",
             "Termination", "Mortality"),
  value = c(-350300,-17500,-699800,-92400,1782500,
            41900,80800,99600,356000),
  Effect=c("Loss", "Loss", "Loss", "Loss", "Gain", "Gain",
           "Gain", "Gain", "Gain")
)

gain_loss2 <- data.frame(
  category=c("Initial", "FAE", "ERR", "DR",
             "Salary", "Mortality", "Misc"),
  value=c(1200800, -242500, 60400, -313000, 84400,
          -89900,-100),
  Effect=c("Gain","Loss", "Gain","Loss","Gain",
           "Loss", "Loss")
)

#' Makes a waterfall plot
#'
#' Makes a waterfall plot using ggplot2.  The bars will be plotted in
#' the order specified by the factoring of the 'category' column.
#' Values should represent the positive or negative changes relative
#' to the previous bar.  
#'
#' @param df a dataframe with columns 'category' (an ordered factor),
#' 'value' (numeric), and 'sector' (character)
#' @param offset the spacing between the columns, default = 0.3
#'
#' @examples
#'  raw <- data.frame(category=c("A", "B", "C", "D"),
#'                    value=c(100, -20, 10, 90),
#'                    sector=1)
#'
#'  df1 <- transform(raw, category=factor(category))                
#'  waterfall(df1) + theme_bw() + labs(x="", y="Value")
#'
#'  df2 <- transform(raw, category=factor(category, levels=c("A", "C", "B", "D")))
#'  waterfall(df2) + theme_bw() + labs(x="", y="Value")
#'
#' @return a ggplot2 object
waterfall <- function(df, offset=0.3) {
  
  library(ggplot2)
  library(scales)
  library(dplyr)
  
  ## Add the order column to the raw data frame and order appropriately
  #df <- df %>% mutate(order=as.numeric(category)) %>% arrange(order)
  df$order <- 1:(dim(df)[1])
  
  ## The last value needs to be negated so that it goes down to
  ## zero.  Throws a warning if the cumulative sum doesn't match.
  last.id <- nrow(df)
  #df$value[last.id] <- -df$value[last.id]
  
  ## Calculate the cumulative sums
  df <- df %>% mutate(cs1=cumsum(value))
  
  ## Throw a warning if the values don't match zero as expected
  final_value <- tail(df$cs1, 1)
  #if (final_value!=0) {
  #  warning(sprintf("Final value doesn't return to 0.  %.2d instead.", final_value))
  #}
  
  ## Calculate the max and mins for each category and sector
  df <- transform(df, min.val=c(0, head(cs1, -1)),
                  max.val=c(head(cs1, -1), 0))    
  df <- df %>% group_by(order, category, Effect, value, cs1) %>%
    summarize(min=min(min.val, max.val), max=max(min.val, max.val))
  
  ## Create the lines data frame to link the bars
  lines <- df %>% group_by(order) %>% summarize(cs=max(cs1))
  lines <- with(lines, data.frame(x=head(order, -1),
                                  xend=tail(order, -1),
                                  y=head(cs, -1),
                                  yend=head(cs, -1)))
  
  
  ## Add the offset parameter
  df <- transform(df, offset=offset)
  df$min[(dim(df)[1])] <- tail(df$cs1, 1)
  ## Make the plot    
  gg <- ggplot() +
    geom_segment(data=lines, aes(x=x, y=y, xend=xend, yend=yend), linetype="dashed")  +
    geom_rect(data=df, aes(xmin=order - offset,
                           xmax=order + offset, 
                           ymin=min,
                           ymax=max, fill=Effect)) +
    scale_x_continuous(breaks=unique(df$order), labels=unique(df$category))
  
  return(gg + scale_y_continuous(labels=function(x) format(x, big.mark = ",", scientific = FALSE))
         + labs(x="",y="") + theme(panel.background = element_rect(fill = 'white', colour = 'black'),
                                   text = element_text(size=12), 
                                   axis.text.x=element_text(colour="black"),
                                   axis.text.y=element_text(colour="black"),
                                   legend.position='none'))
}

options(warn=-1)
p1 <- waterfall(gain_loss1, 0.3) 
show(p1)
p2 <- waterfall(gain_loss2, 0.3)
show(p2)
