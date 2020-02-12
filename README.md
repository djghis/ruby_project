OnTrack: spending tracker application

The project brief was as follows:

  MVP:
    The app should allow the user to create, edit and delete merchants, e.g. Tesco, Amazon, ScotRail
    The app should allow the user to create, edit and delete tags for their spending, e.g. groceries, entertainment, transport
    The user should be able to assign tags and merchants to a transaction, as well as an amount spent on each transaction.
    The app should display all the transactions a user has made in a single view, with each transaction's amount, merchant and tag, and a total for all transactions.


  Possible Extensions:
    Transactions should have a timestamp, and the user should be able to view transactions sorted by the time they took place.
    The user should be able to supply a budget, and the app should alert the user somehow when when they are nearing this budget or have gone over it.
    The user should be able to filter their view of transactions, for example, to view all transactions in a given month, or view all spending on groceries.


I finished the MVPs with time to spare on extensions. Personally I had decided that the budget feature would be a part of my MVP too, as I found that that was the feature that made this app useful in the first place. Therefore OnTrack allows a user to set a monthly budget. Every transaction that the user adds is added to the monthly total for transactions, and the monthly budget is compared to this. The remaining budget is always clearly visible on the user's homepage in a large circle that changes colour from green to orange to red depending on whether the user still has more than £50.00 left of their budget, between £0 and £50.00 or they have gone over budget, respectively. This could also be done as a percentage of the user's starting budget, e.g. 25% instead of a £50.00 cut-off point, but for the purposes of demonstrating this app, it made more sense to choose a clear number.

The top and bottom navigation bars allow the user to add new transactions, add new merchants and add new tags, as well as edit their own budget and view monthly spending summaries. These summaries simply show the remaining budget at the end of each month, again colour coded to show the user whether they stayed well within the budget, within the budget or not within the budget. The user can also view all transactions they have made, and view or edit them individually. The transactions index also provides a button to simply show transactions made during the current month.
