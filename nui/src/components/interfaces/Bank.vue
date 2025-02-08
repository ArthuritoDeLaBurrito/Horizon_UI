<template>
  <body v-if="visible">
    <section class="cards main_bank p-4">
        <button class="log_out" id="log_out" onclick="Close()"><i class="fa-solid fa-right-from-bracket"></i> Log out</button>
            <div class="row h-100">
              <div class="col-2 w-25" style="border-right: solid 2px #939393;">
                <div class="row row-cols-1">
                    <div class="col"><div class="logo"></div><hr></div>
                    <div class="col">
                        <div class="user float-start"></div>
                        <div class="username float-start">User Name <br>Wallet <div class="wallet_amount float-end">$0</div></div>
                        <hr>
                    </div>
                    <div class="col mb-2"><button class="sidebar" id="overview" onclick="UseButton(id)"><i class="fa-solid fa-house-user"></i> Overview</button></div>
                    <div class="col mb-2"><button class="sidebar" id="accounts" onclick="UseButton(id)"><i class="fa-solid fa-credit-card"></i> Accounts</button></div>
                    <div class="col mb-2"><button class="sidebar" id="settings" onclick="UseButton(id)"><i class="fa-solid fa-gear"></i> Settings</button></div>
                </div>
              </div>
              <div class="col">
                <div class="page_datas">
                    <div class="row" style="width: 137%;">
                        <div class="col-4">
                            <h1 class="fw-bold" id="account_name">Current account</h1>
                            <div class="card_bg" onclick="Change_account()">
                                <div class="current_card">
                                    <img src="../../assets/bank/visa_logo.png" class="visa_logo">
                                    <h3 class="card_visa">Visa Classic</h3>
                                    <div class="wifi_logo"><i class="fa-solid fa-wifi fa-rotate-90"></i></div>
                                    <img src="../../assets/bank/card_chip.png" class="card_chip">
                                    <h3 class="card_owner">Jou Rogan</h3>
                                </div>
                            </div>
                            <hr>
                            <h2>Informations</h2>
                            <div class="card_infos">
                                <h3 class="mx-2 mt-4">Balance <div class="balance float-end">$0</div></h3>
                                <h4 class="mx-2 mt-3">IBAN <div class="iban float-end">BS842193</div></h4>
                                <h4 class="mx-2 mt-3">Owner <div class="owner float-end">You</div></h4>
                                <h4 class="mx-2 mt-3">Permission <div class="permission float-end">All</div></h4>
                                <h4 class="mx-2 mt-3">Created <div class="created float-end">2023/05/02</div></h4>
                            </div>
                            <button class="transaction_btn float-start px-3 mt-4" data-bs-toggle="modal" data-bs-target="#new_partner_modal"><i class="fa-solid fa-plus"></i> <i class="fa-solid fa-user"></i></button>
                            <button class="transaction_btn float-end px-3 mt-4" data-bs-toggle="modal" data-bs-target="#new_transaction_modal"><i class="fa-solid fa-plus"></i> New transaction</button>
                        </div>
                        <div class="col">
                            <div class="analytics mt-3 px-2">
                                <div class="row">
                                    <div class="col"><h5 class="ms-2 mt-2 pt-2">Your balance <div class="balance_block float-end mt-2 me-4"></div></h5></div>
                                    <div class="col"><h4 class="m-2 pt-2 text-end">Analytics</h4></div>
                                </div>
                                <div class="chart-container">
                                    <canvas id="myChart"></canvas>
                                </div>
                            </div>
                            <div class="payments mt-3">
                                <div class="row">
                                    <div class="col"><button class="payment_btn px-3 m-2 float-start" data-bs-toggle="modal" data-bs-target="#payments_modal"><i class="fa-solid fa-up-right-from-square fa-flip-horizontal"></i> View all</button></div>
                                    <div class="col"><h4 class="mt-2 me-2 text-end">Payment history</h4></div>
                                </div>
                                <div class="payments_con">
                                    <div class="table_container">
                                        <div class="table_element">
                                            <table class="table table-borderless">
                                                <tbody>
                                                    <tr>
                                                        <th class="type align-middle"><i class="fa-solid fa-angles-down"></i></th>
                                                        <th class="amount align-middle">$55.00</th>
                                                        <th class="action align-middle">Otto</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-3"></div>
                      </div>
                </div>
            </div>
          </div>
    </section>

    <section class="pincode_section">
        <button class="payment_btn px-3 m-3" onclick="Close()"><i class="fa-solid fa-chevron-left"></i> Back</button>
        <div class="d-flex flex-column justify-content-center align-items-center">
            <h1 class="text-center">Input PIN</h1>
            <div class="dots d-flex">
                <div class="dot"></div>
                <div class="dot"></div>
                <div class="dot"></div>
                <div class="dot"></div>
            </div>
            <div class="row row-cols-3 mt-4" style="width: 80%;">
                <div class="col"><div class="number">1</div></div>
                <div class="col"><div class="number">2</div></div>
                <div class="col"><div class="number">3</div></div>
                <div class="col"><div class="number">4</div></div>
                <div class="col"><div class="number">5</div></div>
                <div class="col"><div class="number">6</div></div>
                <div class="col"><div class="number">7</div></div>
                <div class="col"><div class="number">8</div></div>
                <div class="col"><div class="number">9</div></div>
                <div class="col"><div class="number"><i class="fa-solid fa-delete-left fa-flip-horizontal"></i></div></div>
                <div class="col"><div class="number">0</div></div>
                <div class="col"><div class="number"><i class="fa-solid fa-right-to-bracket"></i></div></div>
            </div>
        </div>
        
        
    </section>

    <div class="modal fade" id="payments_modal">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content pb-2" style="background: var(--secondary_color); border-radius: 13px; color: var(--text_color);">
            <div class="modal-body">
                <div class="row">
                    <div class="col"><button class="payment_btn float-start px-3" data-bs-dismiss="modal"><i class="fa-solid fa-chevron-left"></i> Back</button></div>
                    <div class="col"><h2 class="modal-title m-3 text-end">Payment history</h2></div>
                </div>
                <div class="payments_con">
                    <div class="table_header">
                        <table class="table table-borderless">
                            <tbody>
                                <tr>
                                    <th class="type align-middle">Type</th>
                                    <th class="amount align-middle">Amount</th>
                                    <th class="action align-middle">Action</th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="table_container_big">
                    </div>
                </div>
            </div>
          </div>
        </div>
    </div>

    <div class="modal fade" id="permissions_modal" tabindex="-1" style="display: none;">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content pb-2" style="background: var(--secondary_color); border-radius: 13px; color: var(--text_color);">
            <div class="modal-body">
                <div class="row">
                    <div class="col">
                        <button class="payment_btn float-start px-3" id="perm_back" data-bs-dismiss="modal" onclick="SavePermission()"><i class="fa-solid fa-chevron-left"></i> Back</button>
                        <button class="payment_btn float-start px-3 ms-3" id="new_member_modal_btn" disabled data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#new_member_modal">Add new member</button>
                    </div>
                    <div class="col"><h2 class="modal-title m-3 text-end">Permissions</h2></div>
                </div>
                <div class="payments_con">
                    <div class="table_header">
                        <table class="table table-borderless">
                            <tbody>
                                <tr>
                                    <th class="per_name text-center w-25 align-middle">Name</th>
                                    <th class="per text-center w-25 align-middle">Permission</th>
                                    <th class="limit text-center w-25 align-middle">Daily limit</th>
                                    <th class="del text-center w-25 align-middle">Delete</th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="per_table_container">
                    </div>
                </div>
            </div>
          </div>
        </div>
    </div>

    <div class="modal fade" id="new_member_modal" tabindex="-1" style="display: none;">
        <div class="modal-dialog modal-dialog-centered modal-md">
          <div class="modal-content pb-2" style="background: var(--secondary_color); border-radius: 13px; color: var(--text_color);">
            <div class="modal-body">
                <div class="row">
                    <div class="col"><button class="payment_btn float-start px-3" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#permissions_modal"><i class="fa-solid fa-chevron-left"></i> Back</button></div>
                    <div class="col-8"><h2 class="modal-title m-3 text-end">New Member</h2></div>
                </div> 
                <div class="row row-cols-1">
                    <div class="col">
                        <div class="addmember_element p-1 w-75">
                            <h3 class="m-2">Player ID</h3>
                            <div class="input-group input-group-lg ms-3 w-50 mb-3">
                                <input type="text" id="in_target_id" class="form-control" placeholder="ID" onkeypress="return isNumber(event)" style="background-color: var(--secondary_color);">
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="addmember_element p-1 w-75">
                            <h3 class="m-2">Permission</h3>
                            <div class="dropdown mb-3 fs-5">
                                <button class="payment_btn fs-6 px-3 ms-3 dropdown-toggle" id="add_perm_btn" type="button" data-bs-toggle="dropdown" aria-expanded="false">Desposit</button>
                                <ul class="dropdown-menu">
                                    <li><button class="dropdown-item" id="all" onclick="ChangeAddPer(id)">All</button></li>
                                    <li><button class="dropdown-item" id="withdraw" onclick="ChangeAddPer(id)">Withdraw</button></li>
                                    <li><button class="dropdown-item" id="deposit" onclick="ChangeAddPer(id)">Deposit</button></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="addmember_element p-1 w-75">
                            <h3 class="m-2">Daily limit</h3>
                            <div class="input-group input-group-lg ms-3 w-50 mb-2">
                                <input type="text" id="in_daily_limit" class="form-control" placeholder="Limit" onkeypress="return isNumber(event)" oninput="SyncInputData(id)" style="background-color: var(--secondary_color);">
                            </div>
                            <input type="range" class="range ms-3 mb-2" value="1" min="1" max="99999" id="range_daily_limit" oninput="SyncRangeData(id)">
                        </div>
                    </div>
                    <div class="col">
                        <button class="transaction_btn float-end px-3" id="add_new_member" disabled onclick="AddNewMember()"><i class="fa-solid fa-plus"></i> Add</button>
                    </div>
                </div>
            </div>
          </div>
        </div>
    </div>

    <div class="modal fade" id="new_account_modal">
        <div class="modal-dialog modal-dialog-centered modal-md">
          <div class="modal-content pb-2" style="background: var(--secondary_color); border-radius: 13px; color: var(--text_color);">
            <div class="modal-body">
                <div class="row">
                    <div class="col"><button class="payment_btn float-start px-3" data-bs-dismiss="modal"><i class="fa-solid fa-chevron-left"></i> Back</button></div>
                    <div class="col-8">
                        <h2 class="modal-title mt-3 me-3 text-end">New account</h2>
                        <h5 class="me-4 mb-3 fs-6 text-end" id="new_account_cost"></h5>
                    </div>
                </div> 
                <div class="row row-cols-1">
                    <div class="col">
                        <div class="addmember_element p-1 w-75">
                            <h3 class="m-2">Account name</h3>
                            <div class="input-group input-group-lg ms-3 w-50 mb-3">
                                <input type="text" id="in_acc_name" class="form-control" placeholder="Name" oninput="setlenght(id)" style="background-color: var(--secondary_color);">
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <button class="transaction_btn float-end px-3" id="create_sub_acc" disabled data-bs-dismiss="modal" onclick="Create_account()"><i class="fa-solid fa-plus"></i> Create</button>
                    </div>
                </div>
            </div>
          </div>
        </div>
    </div>

    <div class="modal fade" id="new_transaction_modal">
        <div class="modal-dialog modal-dialog-centered modal-md">
          <div class="modal-content pb-2" style="background: var(--secondary_color); border-radius: 13px; color: var(--text_color);">
            <div class="modal-body">
                <div class="row">
                    <div class="col"><button class="payment_btn float-start px-3" data-bs-dismiss="modal"><i class="fa-solid fa-chevron-left"></i> Back</button></div>
                    <div class="col-8"><h2 class="modal-title m-3 text-end">New transaction</h2></div>
                </div> 
                <div class="d-flex flex-column justify-content-center align-items-center">
                    <button class="tran_menu_btn px-3 w-75 mt-2" id="choose_deposit" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#deposit_modal">Deposit</button>
                    <button class="tran_menu_btn px-3 w-75 mt-2" id="choose_withdraw" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#withdraw_modal">Withdraw</button>
                    <button class="tran_menu_btn px-3 w-75 mt-2" id="choose_transfer" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#transfer_modal">Transfer</button>
                </div>
            </div>
          </div>
        </div>
    </div>

    <div class="modal fade" id="deposit_modal">
        <div class="modal-dialog modal-dialog-centered modal-md">
          <div class="modal-content pb-2" style="background: var(--secondary_color); border-radius: 13px; color: var(--text_color);">
            <div class="modal-body">
                <div class="row">
                    <div class="col"><button class="payment_btn float-start px-3" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#new_transaction_modal"><i class="fa-solid fa-chevron-left"></i> Back</button></div>
                    <div class="col-8"><h2 class="modal-title m-3 text-end">Deposit</h2></div>
                </div> 
                <div class="input-group input-group-lg mb-3">
                    <input type="text" id="in_deposit_money" class="form-control mx-3 w-100 text-center fs-1" placeholder="Amount" onkeypress="return isNumber(event)" oninput="SetMaximumMoneytran(id); SyncInputData(id)" style="height: 100px;">
                </div>
                <div class="d-flex flex-column justify-content-center align-items-center">
                    <input type="range" class="range ms-3 mb-2" min="1" max="99999" id="range_deposit_money" oninput="SyncRangeData(id)">
                    <button class="transaction_btn w-75 mt-2" id="deposit_money" data-bs-dismiss="modal" disabled onclick="DepositeMoney()">Deposit</button>
                </div>
            </div>
          </div>
        </div>
    </div>

    <div class="modal fade" id="withdraw_modal">
        <div class="modal-dialog modal-dialog-centered modal-md">
          <div class="modal-content pb-2" style="background: var(--secondary_color); border-radius: 13px; color: var(--text_color);">
            <div class="modal-body">
                <div class="row">
                    <div class="col"><button class="payment_btn float-start px-3" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#new_transaction_modal"><i class="fa-solid fa-chevron-left"></i> Back</button></div>
                    <div class="col-8"><h2 class="modal-title m-3 text-end">Withdraw</h2></div>
                </div> 
                <div class="input-group input-group-lg mb-3">
                    <input type="text" id="in_withdraw_money" class="form-control mx-3 w-100 text-center fs-1" placeholder="Amount" onkeypress="return isNumber(event)" oninput="SetMaximumMoneytran(id); SyncInputData(id)" style="height: 100px;">
                </div>
                <div class="d-flex flex-column justify-content-center align-items-center">
                    <input type="range" class="range ms-3 mb-2" min="1" max="99999" id="range_withdraw_money" oninput="SyncRangeData(id)">
                    <button class="transaction_btn w-75 mt-2" id="withdraw_money" data-bs-dismiss="modal" disabled onclick="WithdrawMoney()">Withdraw</button>
                </div>
            </div>
          </div>
        </div>
    </div>

    <div class="modal fade" id="transfer_modal">
        <div class="modal-dialog modal-dialog-centered modal-md">
          <div class="modal-content pb-2" style="background: var(--secondary_color); border-radius: 13px; color: var(--text_color);">
            <div class="modal-body">
                <div class="row">
                    <div class="col"><button class="payment_btn float-start px-3" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#new_transaction_modal"><i class="fa-solid fa-chevron-left"></i> Back</button></div>
                    <div class="col-8"><h2 class="modal-title m-3 text-end">Transfer</h2></div>
                </div> 
                <div class="input-group input-group-lg mb-3">
                    <input type="text" id="in_tran_money" class="form-control mx-3 w-100 text-center fs-1" placeholder="Amount" onkeypress="return isNumber(event)" oninput="SetMaximumMoneytran(id); SyncInputData(id)" style="height: 100px;">
                </div>
                <div class="d-flex flex-column justify-content-center align-items-center transfer_con">
                    <input type="range" class="range ms-3 mb-2" min="1" max="99999" id="range_tran_money" oninput="SyncRangeData(id)">
                    
                    <hr>

                    <div class="inputs_container">
                        <div class="input-group input-group-lg mb-3 px-5">
                            <input type="text" id="in_partner" class="form-control rounded typeahead text-center fs-2" data-provide="typeahead" placeholder="Partner" onchange="IsRealPartner(id)" oninput="IsRealPartner(id)" style="height: 60px;">
                        </div>
    
                        <div class="input-group input-group-lg mb-4 px-5">
                            <input type="text" id="in_iban_money" class="form-control rounded text-center fs-2" placeholder="Iban" oninput="SetLengthIban(id)" onkeypress="return isNumber(event)" style="height: 60px;">
                        </div>
                    </div>

                    <div class="row mb-3 w-75">
                        <div class="col-9">
                            <h4>Group transfer</h4>
                        </div>
                        <div class="col">
                            <label class="custom-control ios-switch float-end">
                                <input type="checkbox" id="group_transfer" class="ios-switch-control-input" onclick="ChangeGroupTransfer(id)">
                                <span class="ios-switch-control-indicator"></span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="partners_con mx-3 w-100"></div>

                    <button class="transaction_btn w-75 mt-3" id="tran_money" data-bs-dismiss="modal" disabled onclick="TransferMoney()">Transfer</button>
                </div>
            </div>
          </div>
        </div>
    </div>

    <div class="modal fade" id="new_partner_modal">
        <div class="modal-dialog modal-dialog-centered modal-md">
          <div class="modal-content pb-2" style="background: var(--secondary_color); border-radius: 13px; color: var(--text_color);">
            <div class="modal-body">
                <div class="row">
                    <div class="col"><button class="payment_btn float-start px-3" data-bs-dismiss="modal"><i class="fa-solid fa-chevron-left"></i> Back</button></div>
                    <div class="col-8"><h2 class="modal-title m-3 text-end">New Partner</h2></div>
                </div> 
                <div class="row row-cols-1">
                    <div class="col">
                        <div class="addmember_element p-1 w-75">
                            <h3 class="m-2">Partner name</h3>
                            <div class="input-group input-group-lg ms-3 w-50 mb-3">
                                <input type="text" id="in_partner_name" class="form-control typeahead rounded" placeholder="Name" onchange="CanAddPartner()" oninput="CanAddPartner()" style="background-color: var(--secondary_color);">
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="addmember_element p-1 w-75">
                            <h3 class="m-2">Partner iban</h3>
                            <div class="input-group input-group-lg ms-3 w-50 mb-3">
                                <input type="text" id="in_partner_iban" class="form-control" placeholder="Iban" oninput="SetLengthIban(id)" onkeypress="return isNumber(event)" style="background-color: var(--secondary_color);">
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <button class="transaction_btn float-end px-3 ms-3" id="add_new_partner" disabled onclick="AddNewPartner()"><i class="fa-solid fa-plus"></i> Add</button>
                        <button class="transaction_btn float-end px-3" id="remove_partner" disabled onclick="RemovePartner()"><i class="fa-solid fa-minus"></i> Remove</button>
                    </div>
                </div>
            </div>
          </div>
        </div>
    </div>

    <div class="modal fade" id="sure_modal">
        <div class="modal-dialog modal-dialog-centered modal-md">
          <div class="modal-content pb-2" style="background: var(--secondary_color); border-radius: 13px; color: var(--text_color);">
            <div class="modal-body">
                <div class="row row-cols-1">
                    <div class="col"><button class="payment_btn float-start px-3" data-bs-dismiss="modal"><i class="fa-solid fa-chevron-left"></i> Back</button></div>
                    <div class="col"><h1 class="modal-title m-3 text-center">Are you sure?</h1></div>
                </div> 
                <div class="row">
                    <div class="col"></div>
                    <div class="col-4"><button class="transaction_btn px-3 mt-2 w-100 fs-2" id="no" data-bs-dismiss="modal">No</button></div>
                    <div class="col-4"><button class="transaction_btn px-3 mt-2 w-100 fs-2" id="yes" data-bs-dismiss="modal" onclick="returnsure(id)">Yes</button></div>
                    <div class="col"></div>
                </div> 
            </div>
          </div>
        </div>
    </div>
  </body>
</template>

<script setup>
  import { ref, onMounted } from 'vue';
  const ColorConfig = ["rgba(15,210,105,255)", "rgba(237,190,17,255)", "rgba(233,158,15,255)", "rgba(233,17,17,255)", "rgba(234,17,147,255)", "rgba(204,16,234,255)", "rgba(55, 100, 225, 255)", "rgba(71,159,189,255)"]
  const GrafColorConfig = ["rgba(15,210,105,0.6)", "rgba(237,190,17,0.6)", "rgba(233,158,15,0.6)", "rgba(233,17,17,0.6)", "rgba(234,17,147,0.6)", "rgba(204,16,234,0.6)", "rgba(55, 100, 225, 0.6)", "rgba(71,159,189,0.6)"]

  const visible = false
  const Chosed_account = 0
  const Graf_Created = false
  const AddPer = "deposit"
  const CreateName = false
  const CreatePin = false
  const Partners = []
  const OnPage = "overview"
  
  window.addEventListener('message', function(event) {
      let data = event.data
    
      if (data.action === "OpenBankingMenu"){
        Moneyform = data.moneyform
        IbanNumbers = data.ibannumbers 
        MyBankData = data.mybankdata
        PlayerData = data.playerdata
        Costs = data.costs
        DailyLimit = data.dailylimit
        IbanPrefix = data.ibanprefix
        BankLabel = data.banklabel

        show(".main_bank")

        ImportDatas()
        CreatePayments()
        CreateGraf()
        ImportAccountDatas()
        $("#perm_back").html('<i class="fa-solid fa-chevron-left"></i> Back')
      }
      else if (data.action === "OpenAtmMenu"){
        Moneyform = data.moneyform
        IbanNumbers = data.ibannumbers 
        MyBankData = data.mybankdata
        PlayerData = data.playerdata
        Costs = data.costs
        DailyLimit = data.dailylimit
        IbanPrefix = data.ibanprefix
        BankLabel = data.banklabel

        atm_numpad(PlayerData.pincode)
        show(".pincode_section")

        ImportDatas()
        CreatePayments()
        CreateGraf()
        ImportAccountDatas()
        $("#perm_back").html('<i class="fa-solid fa-chevron-left"></i> Back')
      }
      else if (data.action === "RefreshBankingMenu"){
        MyBankData = data.mybankdata
        PlayerData = data.playerdata

        ImportDatas()
        CreatePayments()
        CreateGraf()
        ImportAccountDatas()
        $("#perm_back").html('<i class="fa-solid fa-chevron-left"></i> Back')
        ChangedPermData = false
      }
  })

  document.onkeydown = function(data) {
    if (event.key == 'Escape') {
      Close()
    }
    else if (event.key == 'Enter') {
      AddPartnerbtn()
    }
  }

  function Close(){
    hide(".main_bank")
    hide(".pincode_section")
    setTimeout(function(){
      $('.modal').modal('hide')
    },500)
    $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"close"}))
  }

  function UseButton(id) {
    let data = JSON.stringify({action:id})

    if (id === "settings"){
      $("#"+OnPage).parent().css("border-left", "none")
      OnPage = "settings"
      $("#"+OnPage).parent().css("border-left", "solid 3px var(--main_color)")
      ChangeBetweenPages()
    }
    else if (id === "overview"){
      $("#"+OnPage).parent().css("border-left", "none")
      OnPage = "overview"
      $("#"+OnPage).parent().css("border-left", "solid 3px var(--main_color)")
      ChangeBetweenPages()
    }
    else if (id === "accounts"){
      $("#"+OnPage).parent().css("border-left", "none")
      OnPage = "accounts"
      $("#"+OnPage).parent().css("border-left", "solid 3px var(--main_color)")
      ChangeBetweenPages()
    }

    $.post('https://'+GetParentResourceName()+'/UseButton', data)
  }

  function ImportDatas(){
    $("#"+OnPage).parent().css("border-left", "solid 3px var(--main_color)")
    if (OnPage === "overview"){
      $(".logo").html(BankLabel[0]+'<br><div class="low">'+BankLabel[1]+"</div>")

      $(".user").css("background-image", "url('assets/"+PlayerData.sex+".png')")
    
      $(".username").html(PlayerData.name +'<br>Wallet <div class="wallet_amount float-end">'+Moneyform+PlayerData.money.toLocaleString()+'</div>')
      $(".iban").html(MyBankData[Chosed_account].iban)
      $(".balance").html(Moneyform+MyBankData[Chosed_account].bank.toLocaleString())
      $("#account_name").html(MyBankData[Chosed_account].account_name)
      $(".created").html(MyBankData[Chosed_account].created)
      $(".card_owner").html(MyBankData[Chosed_account].owner_name)
    
      document.getElementById("range_deposit_money").max = PlayerData.money
      document.getElementById("range_withdraw_money").max = MyBankData[Chosed_account].bank
      document.getElementById("range_tran_money").max = MyBankData[Chosed_account].bank
      document.getElementById("range_daily_limit").max = DailyLimit
    
      document.getElementById("range_deposit_money").value = null
      document.getElementById("range_withdraw_money").value = null
      document.getElementById("range_tran_money").value = null
      document.getElementById("range_daily_limit").value = null
    
    
      if (MyBankData[Chosed_account].owner_name === PlayerData.name){
        $(".owner").html("You")
      }
      else{
        $(".owner").html(MyBankData[Chosed_account].owner_name)
      }
    
      if (MyBankData[Chosed_account].mypermission === "all"){
        $(".permission").html("All")
        document.getElementById("choose_withdraw").disabled = false
        document.getElementById("choose_transfer").disabled = false
      }
      else if(MyBankData[Chosed_account].mypermission === "withdraw"){
        $(".permission").html("Withdraw")
        document.getElementById("choose_withdraw").disabled = false
        document.getElementById("choose_transfer").disabled = false
      }
      else{
        $(".permission").html("Deposit")
        document.getElementById("choose_withdraw").disabled = true
        document.getElementById("choose_transfer").disabled = true
      }
    
      TypeAheadList = []
      for(let i = 0; i < PlayerData.partners.length; i++){
        if (PlayerData.partners[i] != undefined){
          TypeAheadList.push(PlayerData.partners[i].name)
        }
      }
    
      var $input = $(".typeahead");
      $input.typeahead({
        autocomplete: true,
        source: TypeAheadList,
      });
    
      $input.change(function() {
          var current = $input.typeahead("getActive");
          matches = [];
    
          if (current) {
            if (current.name == $input.val()) {
                matches.push(current.name);
            }
          }
      });
    }
  }

  function ImportAccountDatas(){
    if (OnPage === "accounts"){

    $("#in_pincode").attr("placeholder", PlayerData.pincode)
    $("#in_iban").attr("placeholder", MyBankData[Chosed_account].iban)
    $("#in_name").attr("placeholder", MyBankData[Chosed_account].account_name)
    $("#new_account_cost").html("An account create is cost "+Moneyform+Costs.sub.toLocaleString())
    $("#account_name").html(MyBankData[Chosed_account].account_name)
    $(".card_owner").html(MyBankData[Chosed_account].owner_name)

    if (MyBankData[Chosed_account].mypermission === "deposit"){
      document.getElementById("delete_account").disabled = true 
      document.getElementById("new_member_modal_btn").disabled = true 
      Dis_All_per = true
    }
    else if (MyBankData[Chosed_account].mypermission === "withdraw"){
      document.getElementById("delete_account").disabled = true 
      document.getElementById("new_member_modal_btn").disabled = true 
      Dis_All_per = true
    }
    else if (MyBankData[Chosed_account].mypermission === "all" && Chosed_account != 0){
      if (MyBankData[Chosed_account].owner === PlayerData.identifier){
        document.getElementById("delete_account").disabled = false 
      }
      document.getElementById("new_member_modal_btn").disabled = false 
      Dis_All_per = false
    }

    if (Chosed_account === 0){
      document.getElementById("manage_perms").disabled = true
      document.getElementById("delete_account").disabled = true 
    }
    else{
      document.getElementById("manage_perms").disabled = false
    }

    $(".per_table_container").html("")
    for(let i = 0; i < MyBankData[Chosed_account].permissions.length; i++){
      if (MyBankData[Chosed_account].permissions[i].permission === "all"){
        Perm = "All"
      }
      else if (MyBankData[Chosed_account].permissions[i].permission === "withdraw"){
        Perm = "Withdraw"
      }
      else if (MyBankData[Chosed_account].permissions[i].permission === "deposit"){
        Perm = "Deposit"
      }
      if (Dis_All_per === true || MyBankData[Chosed_account].permissions[i].identifier === MyBankData[Chosed_account].owner || MyBankData[Chosed_account].permissions[i].identifier === PlayerData.identifier){
        $(".per_table_container").append(`
        <div class="table_element">
            <table class="table table-borderless">
                <tbody>
                    <tr>
                        <th class="per_name text-center w-25 align-middle">${MyBankData[Chosed_account].permissions[i].name}</th>
                        <th class="per text-center w-25 align-middle">
                          <div class="dropdown">
                            <button class="payment_btn fs-6 px-3 dropdown-toggle" type="button" id="permission_btn-${MyBankData[Chosed_account].permissions[i].identifier}" data-bs-toggle="dropdown" aria-expanded="false" disabled>
                            ${Perm}
                            </button>
                            <ul class="dropdown-menu">
                              <li><button class="dropdown-item" id="drop1-${MyBankData[Chosed_account].permissions[i].identifier}" disabled onclick="SavePermissionInArray(id)">All</button></li>
                              <li><button class="dropdown-item" id="drop2-${MyBankData[Chosed_account].permissions[i].identifier}" disabled onclick="SavePermissionInArray(id)">Withdraw</button></li>
                              <li><button class="dropdown-item" id="drop3-${MyBankData[Chosed_account].permissions[i].identifier}" disabled onclick="SavePermissionInArray(id)">Deposit</button></li>
                            </ul>
                          </div>
                        </th>
                        <th class="limit text-center w-25 align-middle">
                        <div class="input-group input-group-lg ms-3">
                          <input type="text" id="${MyBankData[Chosed_account].permissions[i].identifier}" class="form-control w-75" value="${MyBankData[Chosed_account].permissions[i].limit}" disabled oninput="SaveLimitInArray(id)" onkeypress="return isNumber(event)"></th>
                        </div>
                        <th class="text-center w-25 align-middle"><button class="del" id="Rem-${MyBankData[Chosed_account].permissions[i].identifier}" style="color: red; background: transparent;" disabled onclick="RemoveFromPermissions(id)"><i class="fa-solid fa-trash"></i></button></th>
                    </tr>
                </tbody>
            </table>
        </div>
        `)
      }
      else{
        $(".per_table_container").append(`
        <div class="table_element">
            <table class="table table-borderless">
                <tbody>
                    <tr>
                        <th class="per_name text-center w-25 align-middle">${MyBankData[Chosed_account].permissions[i].name}</th>
                        <th class="per text-center w-25 align-middle">
                          <div class="dropdown">
                            <button class="payment_btn fs-6 px-3 dropdown-toggle" type="button" id="permission_btn-${MyBankData[Chosed_account].permissions[i].identifier}" data-bs-toggle="dropdown" aria-expanded="false">
                            ${Perm}
                            </button>
                            <ul class="dropdown-menu">
                              <li><button class="dropdown-item" id="drop1-${MyBankData[Chosed_account].permissions[i].identifier}" onclick="SavePermissionInArray(id)">All</button></li>
                              <li><button class="dropdown-item" id="drop2-${MyBankData[Chosed_account].permissions[i].identifier}" onclick="SavePermissionInArray(id)">Withdraw</button></li>
                              <li><button class="dropdown-item" id="drop3-${MyBankData[Chosed_account].permissions[i].identifier}" onclick="SavePermissionInArray(id)">Deposit</button></li>
                            </ul>
                          </div>
                        </th>
                        <th class="limit text-center w-25 align-middle">
                        <div class="input-group input-group-lg ms-3">
                          <input type="text" id="${MyBankData[Chosed_account].permissions[i].identifier}" class="form-control w-75" value="${MyBankData[Chosed_account].permissions[i].limit}" oninput="SaveLimitInArray(id)" onkeypress="return isNumber(event)"></th>
                        </div>
                        <th class="text-center w-25 align-middle"><button class="del" id="Rem-${MyBankData[Chosed_account].permissions[i].identifier}" style="color: red; background: transparent;" onclick="RemoveFromPermissions(id)"><i class="fa-solid fa-trash"></i></button></th>
                    </tr>
                </tbody>
            </table>
        </div>
        `)
      }
      
    }
    }
  }

  function ImportSettigDatas(){
    $(".color-btn-container").html("")
    for(let i = 0; i < ColorConfig.length; i++){
      if (ColorConfig[i] === Menu_color){
        $(".color-btn-container").append(`
        <button class="color_btn mb-3 me-2 float-end" id="${ColorConfig[i]}" style="background: ${ColorConfig[i]};" onclick="Change_color(id)"><i class="fa-solid fa-check"></i></button>
        `)
      }
      else{
        $(".color-btn-container").append(`
        <button class="color_btn mb-3 me-2 float-end" id="${ColorConfig[i]}" style="background: ${ColorConfig[i]};" onclick="Change_color(id)"></button>
        `)
      }
    }
  }

  function SaveLimitInArray(id){
    for(let i = 0; i < MyBankData[Chosed_account].permissions.length; i++){
      if (id === MyBankData[Chosed_account].permissions[i].identifier){
        MyBankData[Chosed_account].permissions[i].limit = document.getElementById(id).value
        ChangedPermData = true
        $("#perm_back").html("Save")
      }
    }
  }

  function SavePermissionInArray(id){
    for(let i = 0; i < MyBankData[Chosed_account].permissions.length; i++){
      if (id.split('-')[1] === MyBankData[Chosed_account].permissions[i].identifier){
        ChangedPermData = true
        $("#perm_back").html("Save")
        if ($("#"+id).html() === "All"){
          MyBankData[Chosed_account].permissions[i].permission = "all"
        }
        else if ($("#"+id).html() === "Withdraw"){
          MyBankData[Chosed_account].permissions[i].permission = "withdraw"
        }
        else if ($("#"+id).html() === "Deposit"){
          MyBankData[Chosed_account].permissions[i].permission = "deposit"
        }
        $("#permission_btn-"+MyBankData[Chosed_account].permissions[i].identifier).html($("#"+id).html())
      }
    }
  }

  function RemoveFromPermissions(id){
    for(let i = 0; i < MyBankData[Chosed_account].permissions.length; i++){
      if (id.split('-')[1] === MyBankData[Chosed_account].permissions[i].identifier && MyBankData[Chosed_account].permissions[i].identifier != PlayerData.identifier && MyBankData[Chosed_account].permissions[i].identifier != MyBankData[Chosed_account].owner){
        MyBankData[Chosed_account].permissions.splice(i, 1)
        ChangedPermData = true
        $("#perm_back").html("Save")
      }
    }
    ImportAccountDatas()
  }

  function SavePermission(){
    if (ChangedPermData === true){
      $("#perm_back").html('<i class="fa-solid fa-chevron-left"></i> Back')
      $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"SavePermission", permission_table:MyBankData[Chosed_account].permissions, account:Chosed_account+1}))
    }
  }

  function AddNewMember(){
    let target_id = document.getElementById("in_target_id").value
    let limit = document.getElementById("in_daily_limit").value
    $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"AddMemberPermission", permission_table:MyBankData[Chosed_account].permissions, target_id, limit, permission:AddPer, account:Chosed_account+1}))
    document.getElementById("in_target_id").value = null
    document.getElementById("in_daily_limit").value = null
  }

  function DepositeMoney(){
    let amount = document.getElementById("in_deposit_money").value
    $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"Deposit", amount, account:Chosed_account+1}))
    document.getElementById("in_deposit_money").value = null
    document.getElementById("range_deposit_money").value = 0
  }

  function WithdrawMoney(){
    let amount = document.getElementById("in_withdraw_money").value
    $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"Withdraw", amount, account:Chosed_account+1}))
    document.getElementById("in_withdraw_money").value = null
    document.getElementById("range_withdraw_money").value = 0
  }

  function TransferMoney(){
    if (document.getElementById("group_transfer").checked === false){
      let amount = document.getElementById("in_tran_money").value
      let iban = IbanPrefix+document.getElementById("in_iban_money").value
      $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"Transfer", amount, account:Chosed_account+1, iban}))
    }
    else{
      SendTransfer()
    }
    
  }

  const sleep = (time) => {
    return new Promise((resolve) => setTimeout(resolve, time))
  }

  const SendTransfer = async () => {
    for(let i = 0; i < Partners.length; i++){
      if (containsOnlyNumbers(Partners[i])){
        let amount = document.getElementById("in_tran_money").value
        let iban = IbanPrefix+Partners[i]
        $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"Transfer", amount, account:Chosed_account+1, iban}))
      }
      else{
        for(let _i = 0; _i < PlayerData.partners.length; _i++){
          if (Partners[i] === PlayerData.partners[_i].name){
            let amount = document.getElementById("in_tran_money").value
            let iban = PlayerData.partners[_i].iban
            $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"Transfer", amount, account:Chosed_account+1, iban}))
          }
        }
      } 
      await sleep(500)
    }
    document.getElementById("in_tran_money").value = null
    document.getElementById("range_tran_money").value = 0
  }

  function ChangeAddPer(id){
    AddPer = id
    $("#add_perm_btn").html($("#"+id).html())
  }


  function Change_color(id){
    Menu_color = id
    var r = document.querySelector(':root')
    r.style.setProperty('--main_color', Menu_color)
    localStorage.setItem("Menu_color", Menu_color)
    ImportSettigDatas()
  }

  function Change_account(){
    if (MyBankData.length > 1){
      if (Chosed_account < +MyBankData.length-+1){
        Chosed_account++
      }
      else{
        Chosed_account = 0
      }
      if (OnPage === "overview"){
        ImportDatas()
        CreatePayments()
        CreateGraf()
      }
      else if(OnPage === "accounts"){
        ImportAccountDatas()
      }
      $("#account_name").html(MyBankData[Chosed_account].account_name)
    }
  }

  function Change_pin(){
    $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"ChangePIN", value:document.getElementById("in_pincode").value}))
    document.getElementById("in_pincode").value = ""
    document.getElementById("btn_pincode").disabled = true
  }

  function Change_iban(){
    $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"ChangeIBAN", value:document.getElementById("in_iban").value, account:Chosed_account+1}))
    document.getElementById("in_iban").value = ""
    document.getElementById("btn_iban").disabled = true
  }

  function Change_name(){
    $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"ChangeNAME", value:document.getElementById("in_name").value, account:Chosed_account+1}))
    document.getElementById("in_name").value = ""
    document.getElementById("btn_name").disabled = true
  }

  function CreatePayments(){
    Transactions_graf = []
    $(".table_container").html("")
    for(let i = MyBankData[Chosed_account].transactions.length-1; i > -1; i = i-1){
      let Label = MyBankData[Chosed_account].transactions[i].label
      if (MyBankData[Chosed_account].transactions[i].label.length > 13){
        Label = MyBankData[Chosed_account].transactions[i].label.substring(0, 10)+"..."
      }
      if(MyBankData[Chosed_account].transactions[i].type === "add"){
        $(".table_container").append(`
        <div class="table_element">
            <table class="table table-borderless">
                <tbody>
                    <tr>
                        <th class="type align-middle"><i class="fa-solid fa-angles-up"></i></th>
                        <th class="amount align-middle">+ ${Moneyform+MyBankData[Chosed_account].transactions[i].amount.toLocaleString()}</th>
                        <th class="action align-middle">${Label}</th>
                    </tr>
                </tbody>
            </table>
        </div>
        `)
      }
      else{
        $(".table_container").append(`
        <div class="table_element">
            <table class="table table-borderless">
                <tbody>
                    <tr>
                        <th class="type align-middle"><i class="fa-solid fa-angles-down"></i></th>
                        <th class="amount align-middle" style="color: red;">- ${Moneyform+MyBankData[Chosed_account].transactions[i].amount.toLocaleString()}</th>
                        <th class="action align-middle">${Label}</th>
                    </tr>
                </tbody>
            </table>
        </div>
        `)
      }
    }

    $(".table_container_big").html("")
    for(let i = MyBankData[Chosed_account].transactions.length-1; i > -1; i = i-1){
      let Label = MyBankData[Chosed_account].transactions[i].label
      if (MyBankData[Chosed_account].transactions[i].label.length > 20){
        Label = MyBankData[Chosed_account].transactions[i].label.substring(0, 17)+"..."
      }
      if(MyBankData[Chosed_account].transactions[i].type === "add"){
        $(".table_container_big").append(`
        <div class="table_element">
            <table class="table table-borderless">
                <tbody>
                    <tr>
                        <th class="type align-middle"><i class="fa-solid fa-angles-up"></i></th>
                        <th class="amount align-middle">+ ${Moneyform+MyBankData[Chosed_account].transactions[i].amount.toLocaleString()}</th>
                        <th class="action align-middle">${Label}</th>
                    </tr>
                </tbody>
            </table>
        </div>
        `)
      }
      else{
        $(".table_container_big").append(`
        <div class="table_element">
            <table class="table table-borderless">
                <tbody>
                    <tr>
                        <th class="type align-middle"><i class="fa-solid fa-angles-down"></i></th>
                        <th class="amount align-middle" style="color: red;">- ${Moneyform+MyBankData[Chosed_account].transactions[i].amount.toLocaleString()}</th>
                        <th class="action align-middle">${Label}</th>
                    </tr>
                </tbody>
            </table>
        </div>
        `)
      }
    }

    for(let i = 0; i < MyBankData[Chosed_account].transactions.length; i++){
      Transactions_graf.push(MyBankData[Chosed_account].transactions[i].balance)
    }
  }

  function Create_account(){
    let account_name = document.getElementById("in_acc_name").value
    $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"CreateSubAccount", account_name}))
    document.getElementById("in_acc_name").value = null
  }

  function CreateGraf(){
    if (Transactions_graf.length > 1 && OnPage === "overview"){
      $(".chart-container").html('<canvas id="myChart"></canvas>')
      xValues = []
      for(let i = 0; i < Transactions_graf.length; i++){
        xValues.push("")
      }
    
      var ctx = document.getElementById('myChart').getContext('2d');
      var gradient = ctx.createLinearGradient(0, 0, 0, 200);

      for(let i = 0; i < ColorConfig.length; i++){
        if (Menu_color === ColorConfig[i]){
          Graf_color = GrafColorConfig[i]
        }
      }

      gradient.addColorStop(0, Graf_color);
      gradient.addColorStop(1, 'rgba(0, 0, 0, 0)');
    
      if (Graf_Created){
        myChart.destroy();
      }
    
      myChart = new Chart("myChart", {
        type: "line",
        data: {
          labels: xValues,
          datasets: [{ 
            data: Transactions_graf,
            borderColor: Menu_color,
            backgroundColor: gradient,
            fill: 'start',
            pointRadius: 0,
            pointHoverRadius: 6,
            pointHitRadius: 16,
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            x: {
              grid: {
                display: false
              }
            },
            y: {
              grid: {
                lineWidth: 1,
                color: "rgba(149, 149, 149, 90)",
                drawBorder: false
              }
            }
          },
          animations: {
            tension: {
              duration: 750,
              easing: 'linear',
              from: 0.65,
              to: 0.45,
              loop: false
            }
        },
        plugins: {
          legend: {
            display: false
          }
        },
        }
      });
      Graf_Created = true
    }
    else{
      $(".chart-container").html('<h2 class="text-center">There are not enough payments</h2>')
    }
    
  }

  function ChangeBetweenPages(){
    if (OnPage === "overview"){
      $(".page_datas").html(`
      <div class="row" style="width: 137%;">
        <div class="col-4">
            <h1 class="fw-bold" id="account_name">Current account</h1>
            <div class="card_bg" onclick="Change_account()">
                <div class="current_card">
                  <img src="assets/visa_logo.png" class="visa_logo">
                  <h3 class="card_visa">Visa Classic</h3>
                  <div class="wifi_logo"><i class="fa-solid fa-wifi fa-rotate-90"></i></div>
                  <img src="assets/card_chip.png" class="card_chip">
                  <h3 class="card_owner">Jou Rogan</h3>
                </div>
            </div>
            <hr>
            <h2>Informations</h2>
            <div class="card_infos">
                <h3 class="mx-2 mt-4">Balance <div class="balance float-end">$0</div></h3>
                <h4 class="mx-2 mt-3">IBAN <div class="iban float-end">BS842193</div></h4>
                <h4 class="mx-2 mt-3">Owner <div class="owner float-end">You</div></h4>
                <h4 class="mx-2 mt-3">Permission <div class="permission float-end">All</div></h4>
                <h4 class="mx-2 mt-3">Created <div class="created float-end">2023/05/02</div></h4>
            </div>
            <button class="transaction_btn float-start px-3 mt-4" data-bs-toggle="modal" data-bs-target="#new_partner_modal"><i class="fa-solid fa-plus"></i> <i class="fa-solid fa-user"></i></button>
            <button class="transaction_btn float-end px-3 mt-4" data-bs-toggle="modal" data-bs-target="#new_transaction_modal"><i class="fa-solid fa-plus"></i> New transaction</button>
        </div>
        <div class="col">
            <div class="analytics mt-3 px-2">
            <div class="row">
              <div class="col"><h5 class="ms-2 mt-2 pt-2">Your balance <div class="balance_block float-end mt-2 me-4"></div></h5></div>
              <div class="col"><h4 class="m-2 pt-2 text-end">Analytics</h4></div>
            </div>
                <div class="chart-container">
                  <canvas id="myChart"></canvas>
                </div>
            </div>
            <div class="payments mt-3">
            <div class="row">
              <div class="col"><button class="payment_btn px-3 m-2 float-start" data-bs-toggle="modal" data-bs-target="#payments_modal"><i class="fa-solid fa-up-right-from-square fa-flip-horizontal"></i> View all</button></div>
              <div class="col"><h4 class="mt-2 me-2 text-end">Payment history</h4></div>
            </div>
                <div class="payments_con">
                    <div class="table_container">
                        <div class="table_element">
                            <table class="table table-borderless">
                                <tbody>
                                    <tr>
                                        <th class="amount align-middle">$55.00</th>
                                        <th class="type align-middle"><i class="fa-solid fa-angles-down"></i></th>
                                        <th class="name align-middle">Otto</th>
                                        <th class="date align-middle">2023.10.01</th>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-3"></div>
      </div> `)

      ImportDatas()
      CreatePayments()
      CreateGraf()
    }
    else if(OnPage === "accounts"){
      $(".page_datas").html(`
      <div class="row row-cols-1">
        <div class="col">
            <div class="row">
              <div class="col">
                <h1 class="fw-bold" id="account_name">Current account</h1>
                <div class="card_bg m-0" onclick="Change_account()">
                    <div class="current_card">
                        <img src="assets/visa_logo.png" class="visa_logo">
                        <h3 class="card_visa">Visa Classic</h3>
                        <div class="wifi_logo"><i class="fa-solid fa-wifi fa-rotate-90"></i></div>
                        <img src="assets/card_chip.png" class="card_chip">
                        <h3 class="card_owner">Jou Rogan</h3>
                    </div>
                </div>
              </div>
              <div class="col">
                <div class="settings_element mt-2">
                    <div class="row row-cols-1">
                        <div class="col">
                          <button class="transaction_btn my-3 px-3 mx-5 align-middle w-75" id="create_account" data-bs-toggle="modal" data-bs-target="#new_account_modal">Create New Account</button>
                        </div>
                    </div>
                </div>
                <div class="settings_element mt-3">
                    <div class="row row-cols-1">
                        <div class="col">
                            <h4 class="mt-2 ms-3">Change PIN</h4>
                            <h5 class="ms-4 mb-3 fs-6 sec_text">A pin change is cost about ${Moneyform+Costs.pincode.toLocaleString()}</h5>
                        </div>
                        <div class="col">
                            <div class="row">
                                <div class="col"> 
                                    <div class="input-group input-group-lg ms-3">
                                        <input type="text" id="in_pincode" class="form-control" placeholder="${MyBankData[Chosed_account].pincode}" oninput="setlenght(id)" onkeypress="return isNumber(event)">
                                    </div>
                                </div>
                                <div class="col"><button class="transaction_btn me-3 mb-3 px-3 float-end" id="btn_pincode" onclick="Change_pin()" disabled="true">Submit</button></div>
                            </div>
                        </div>
                    </div>
                </div>
              </div>
            </div>
            <hr>
        </div>
        <div class="col">
            <h2>Management</h2>
            <div class="row">
                <div class="col">
                    <div class="settings_element mb-3">
                        <div class="row row-cols-1">
                            <div class="col">
                                <h4 class="mt-2 ms-3">Change IBAN</h4>
                                <h5 class="ms-4 mb-3 fs-6 sec_text">A iban change is cost about ${Moneyform+Costs.iban.toLocaleString()}</h5>
                            </div>
                            <div class="col">
                                <div class="row">
                                    <div class="col"> 
                                        <div class="input-group input-group-lg ms-3">
                                            <input type="text" id="in_iban" class="form-control" placeholder="${MyBankData[Chosed_account].iban}" oninput="setlenght(id)" onkeypress="return isNumber(event)">
                                        </div>
                                    </div>
                                    <div class="col"><button class="transaction_btn me-3 mb-3 px-3 float-end" id="btn_iban" onclick="Change_iban()" disabled="true">Submit</button></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="settings_element mt-3">
                        <div class="row row-cols-1">
                            <div class="col">
                                <h4 class="mt-2 ms-3 mb-2">Delete account</h4>
                                <h5 class="ms-4 mb-3 fs-6 sec_text">Delete you sub-account definitively</h5>
                            </div>
                            <div class="col">
                              <button class="transaction_btn mb-3 px-3 mx-5 align-middle w-75" id="delete_account" disabled data-bs-toggle="modal" data-bs-target="#sure_modal">Delete</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="settings_element mb-3">
                        <div class="row row-cols-1">
                            <div class="col">
                                <h4 class="mt-2 ms-3">Change account name</h4>
                                <h5 class="ms-4 mb-3 fs-6 sec_text">An account name change is free</h5>
                            </div>
                            <div class="col">
                                <div class="row">
                                    <div class="col"> 
                                        <div class="input-group input-group-lg ms-3">
                                            <input type="text" id="in_name" class="form-control" placeholder="${MyBankData[Chosed_account].account_name}" oninput="setlenght(id)">
                                        </div>
                                    </div>
                                    <div class="col"><button class="transaction_btn me-3 mb-3 px-3 float-end" id="btn_name" onclick="Change_name()" disabled="true">Submit</button></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="settings_element mb-3">
                        <div class="row row-cols-1">
                            <div class="col">
                                <h4 class="mt-2 ms-3">Permissions</h4>
                                <h5 class="ms-4 mb-3 fs-6 sec_text">Manage the members of the account</h5>
                            </div>
                            <div class="col">
                                <button class="transaction_btn mb-3 px-3 mx-5 align-middle w-75" id="manage_perms" data-bs-toggle="modal" data-bs-target="#permissions_modal" onclick="UseButton(id)" disabled="true">Manage</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
      `)

      ImportAccountDatas()
    }
    else if(OnPage === "settings"){
      $(".page_datas").css("width","auto")
      $(".page_datas").html(`
      <div class="row">
        <div class="col">
          <h1 class="fw-bold mb-4">Settings</h1>
          <div class="settings_element mb-3">
              <div class="row">
                  <div class="col">
                      <h3 class="m-3">Choose your theme</h3>
                  </div>
                  <div class="col">
                      <button class="theme_btn my-3 me-3 float-end bg-dark" id="dark_theme" onclick="Change_theme(id)"></button>
                      <button class="theme_btn my-3 me-2 float-end" id="white_theme" onclick="Change_theme(id)"></button>
                  </div>
              </div>
          </div>
          <div class="settings_element mb-3">
              <div class="row row-cols-1">
                  <div class="col">
                      <h3 class="mt-3 ms-3">Choose your color</h3>
                  </div>
                  <div class="col">
                    <div class="color-btn-container"></div>
                  </div>
              </div>
          </div>
        </div>
      </div>
      `)
      ImportSettigDatas()
    }
  }

  function returnsure(id){
    if (id === "yes"){
      $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"DeleteSubAccount", account:Chosed_account+1}))
      Chosed_account = 0
    }
  }

  function show(element){
    $(element).css("display", "block")
    setTimeout(function(){
        $(element).css("opacity", "1")
    }, 10);
  }

  function hide(element){
    $(element).css("opacity", "0")
    setTimeout(function(){
      $(element).css("display", "none")
    }, 400)
  }

  function fancyTimeFormat(duration){   
    var hrs = ~~(duration / 3600);
    var mins = ~~((duration % 3600) / 60);
    var secs = ~~duration % 60;

    var ret = "";

    if (hrs > 0) {
        ret += "" + hrs + ":" + (mins < 10 ? "0" : "");
    }

    ret += "" + mins + ":" + (secs < 10 ? "0" : "");
    ret += "" + secs;
    return ret;
  }

  function isNumber(evt){
    evt = (evt) ? evt : window.event
    var charCode = (evt.which) ? evt.which : evt.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false
    }
    return true
  }

  function setlenght(id) {
    if (id === "in_pincode" || id === "in_acc_pin"){
      if (document.getElementById(id).value.length === 4 && id === "in_pincode" && MyBankData[Chosed_account].mypermission === "all"){
        document.getElementById("btn_pincode").disabled = false
      }
      else if (document.getElementById(id).value.length === 5){
        document.getElementById(id).value = document.getElementById(id).value.substring(0, document.getElementById(id).value.length - 1)
      }
      else if (document.getElementById(id).value.length < 4 && id === "in_pincode"){
        document.getElementById("btn_pincode").disabled = true
      }
    }
    else if (id === "in_iban"){
      if (document.getElementById(id).value.length === IbanNumbers && MyBankData[Chosed_account].mypermission === "all" && OnPage != "overview"){
        document.getElementById("btn_iban").disabled = false
      }
      else if (document.getElementById(id).value.length === IbanNumbers+1){
        document.getElementById(id).value = document.getElementById(id).value.substring(0, document.getElementById(id).value.length - 1)
      }
      else if (document.getElementById(id).value.length < IbanNumbers && OnPage != "overview"){
        document.getElementById("btn_iban").disabled = true
      }
    }
    else if (id === "in_name" || id === "in_acc_name"){
      if (document.getElementById(id).value.length === 3 && id === "in_name" && MyBankData[Chosed_account].mypermission === "all"){
        document.getElementById("btn_name").disabled = false
      }
      else if (document.getElementById(id).value.length === 3 && id === "in_acc_name"){
        document.getElementById("create_sub_acc").disabled = false
      }
      else if (document.getElementById(id).value.length === 30){
        document.getElementById(id).value = document.getElementById(id).value.substring(0, document.getElementById(id).value.length - 1)
      }
      else if (document.getElementById(id).value.length < 3 && id === "in_name"){
        document.getElementById("btn_name").disabled = true
      }
      else if (document.getElementById(id).value.length < 3 && id === "in_acc_name"){
        document.getElementById("create_sub_acc").disabled = true
      }
    }
  
  }

  function SetMaximumMoneytran(id){
    if (id === "in_daily_limit"){
      if (document.getElementById(id).value > DailyLimit){
        document.getElementById(id).value = DailyLimit
      }
    }
    else if (id === "in_deposit_money"){
      if (document.getElementById(id).value > PlayerData.money){
        document.getElementById(id).value = PlayerData.money
      }
      CanUseBtn("in_deposit_money","deposit_money")
    }
    else if (id === "in_withdraw_money"){
      if (document.getElementById(id).value > MyBankData[Chosed_account].bank){
        document.getElementById(id).value = MyBankData[Chosed_account].bank
      }
      CanUseBtn("in_withdraw_money","withdraw_money")
    }
    else if (id === "in_tran_money"){
      if (document.getElementById(id).value > MyBankData[Chosed_account].bank){
        document.getElementById(id).value = MyBankData[Chosed_account].bank
      }
      CanTransfer()
    }
    
  }

  function SyncRangeData(id){
    if (id === "range_daily_limit"){
      document.getElementById("in_daily_limit").value = document.getElementById(id).value
      CanUseBtn("in_daily_limit", "add_new_member")
    }
    else if (id === "range_deposit_money"){
      CanUseBtn("in_deposit_money","deposit_money")
      document.getElementById("in_deposit_money").value = document.getElementById(id).value
    }
    else if (id === "range_withdraw_money"){
      CanUseBtn("in_withdraw_money","withdraw_money")
      document.getElementById("in_withdraw_money").value = document.getElementById(id).value
    }
    else if (id === "range_tran_money"){
      CanTransfer()
      document.getElementById("in_tran_money").value = document.getElementById(id).value
    }
  }

  function SyncInputData(id){
    if (id === "in_daily_limit"){
      CanUseBtn("in_daily_limit", "add_new_member")
      document.getElementById("range_daily_limit").value = document.getElementById(id).value
    }
    else if (id === "in_deposit_money"){
      document.getElementById("range_deposit_money").value = document.getElementById(id).value
    }
    else if (id === "in_withdraw_money"){
      document.getElementById("range_withdraw_money").value = document.getElementById(id).value
    }
    else if (id === "in_tran_money"){
      document.getElementById("range_tran_money").value = document.getElementById(id).value
    }
  }

  function CanUseBtn(input, btn){
    if (+document.getElementById(input).value > 0){
      document.getElementById(btn).disabled = false
    }
    else{
      document.getElementById(btn).disabled = true
    }
  }

  function IsRealPartner(id){
      let Partner = document.getElementById(id).value
      let found = false
      for(let i = 0; i < PlayerData.partners.length; i++){
        if (Partner === PlayerData.partners[i].name){
          found = true
          document.getElementById("in_iban_money").value = PlayerData.partners[i].iban.slice(IbanPrefix.length)
          CanTransfer()
        }
      }
      if (found === false){
        document.getElementById("in_iban_money").value = null
        CanTransfer()
      }
  }

  function RemoveTranPartner(id){
    const child = document.getElementById(id)
    let Name = child.previousSibling.innerHTML  

    for(let i = 0; i < Partners.length; i++){
      if(Partners[i] === Name.slice(2)){
        delete Partners.splice(i, 1)
      }
    }

    CanTransfer()

    child.parentElement.remove()
  }

  function AddPartner(Name){
    let NewPartner = true

    for(let i = 0; i < Partners.length; i++){
      if (Partners[i] === Name){
        NewPartner = false
      }
    }

    if (NewPartner === true){
      Partners.push(Name)
    }

    CanTransfer()

    $(".partners_container").html("")
    for(let i = 0; i < Partners.length; i++){
      if (containsOnlyNumbers(Partners[i])){
        $(".partners_container").append(`
        <div class="partner_element"><h>${IbanPrefix+Partners[i]}</h><button class="remove_partner_btn" id="partner-${i}" onclick="RemoveTranPartner(id)"><i class="fa-solid fa-x"></i></button></div>
        `)
      }
      else{
        $(".partners_container").append(`
        <div class="partner_element"><h>${Partners[i]}</h><button class="remove_partner_btn" id="partner-${i}" onclick="RemoveTranPartner(id)"><i class="fa-solid fa-x"></i></button></div>
        `)
      }
    }
  }

  function ChangeGroupTransfer(id){
    if (document.getElementById(id).checked === true){
      $(".inputs_container").html(`
      <div class="input-group input-group-lg mb-3 px-5">
          <input type="text" id="in_partner" class="form-control rounded typeahead text-center fs-2" data-provide="typeahead" placeholder="Partner" onchange="IsRealPartner(id)" oninput="IsRealPartner(id)" style="height: 60px;">
          <button class="transaction_btn rounded fs-2" onclick="AddPartnerbtn()" style="height: 59px; width: 59px;"><i class="fa-solid fa-plus"></i></button>
      </div>

      <div class="input-group input-group-lg mb-4 px-5">
          <input type="text" id="in_iban_money" class="form-control rounded text-center fs-2" placeholder="Iban" oninput="SetLengthIban(id)" onkeypress="return isNumber(event)" style="height: 60px;">
          <button class="transaction_btn rounded fs-2" onclick="AddPartnerbtn()" style="height: 59px; width: 59px;"><i class="fa-solid fa-plus"></i></button>
      </div>
      `)
      $(".partners_con").append(`<div class="partners_container" id="partners_container"></div>`)
      setTimeout(function(){
        for(let i = 0; i < Partners.length; i++){
          if (containsOnlyNumbers(Partners[i])){
            $(".partners_container").append(`
            <div class="partner_element"><h>${IbanPrefix+Partners[i]}</h><button class="remove_partner_btn" id="partner-${i}" onclick="RemoveTranPartner(id)"><i class="fa-solid fa-x"></i></button></div>
            `)
          }
          else{
            $(".partners_container").append(`
            <div class="partner_element"><h>${Partners[i]}</h><button class="remove_partner_btn" id="partner-${i}" onclick="RemoveTranPartner(id)"><i class="fa-solid fa-x"></i></button></div>
            `)
          }
        }
      },600)
    }
    else{
      $(".inputs_container").html(`
      <div class="input-group input-group-lg mb-3 px-5">
          <input type="text" id="in_partner" class="form-control rounded typeahead text-center fs-2" data-provide="typeahead" placeholder="Partner" onchange="IsRealPartner(id)" oninput="IsRealPartner(id)" style="height: 60px;">
      </div>

      <div class="input-group input-group-lg mb-4 px-5">
          <input type="text" id="in_iban_money" class="form-control rounded text-center fs-2" placeholder="Iban" oninput="SetLengthIban(id)" onkeypress="return isNumber(event)" style="height: 60px;">
      </div>
      `)
      document.getElementById("partners_container").remove()
    }
    ImportPartners()
  }

  function SetLengthIban(id){
    if (document.getElementById(id).value.length === IbanNumbers+1){
      document.getElementById(id).value = document.getElementById(id).value.substring(0, document.getElementById(id).value.length - 1)
    }
    CanTransfer()
    CanAddPartner()
  }

  function CanTransfer(){
    if (+document.getElementById("in_tran_money").value > 0){
      if (document.getElementById("group_transfer").checked === false){
        if (document.getElementById("in_iban_money").value.length === IbanNumbers){
          document.getElementById("tran_money").disabled = false
        }
        else{
          document.getElementById("tran_money").disabled = true
        }
      }
      else if (Partners.length > 0){
        document.getElementById("tran_money").disabled = false
      }
      else{
        document.getElementById("tran_money").disabled = true
      }
    }
    else{
      document.getElementById("tran_money").disabled = true
    }
  }

  function CanAddPartner(){
    let NewPartner = true

    
      for(let i = 0; i < PlayerData.partners.length; i++){
        if (PlayerData.partners[i] != undefined){
          if (PlayerData.partners[i].name === document.getElementById("in_partner_name").value){
            NewPartner = false
          }
        }
      }
    
    if (NewPartner){
      document.getElementById("remove_partner").disabled = true
      if (document.getElementById("in_partner_name").value.length > 2){
        if (document.getElementById("in_partner_name").value.length > 10){
          document.getElementById("in_partner_name").value = document.getElementById("in_partner_name").value.substring(0, document.getElementById("in_partner_name").value.length - 1)
        }
        if (document.getElementById("in_partner_iban").value.length === IbanNumbers){
          document.getElementById("add_new_partner").disabled = false
        }
        else{
          document.getElementById("add_new_partner").disabled = true
        }
      }
      else{
        document.getElementById("add_new_partner").disabled = true
      }
    }
    else{
      document.getElementById("remove_partner").disabled = false
    }
    
    
  }

  function AddPartnerbtn(){
    if (document.getElementById("in_iban_money").value.length === IbanNumbers && OnPage === "overview" && document.getElementById("group_transfer").checked === true){
      let Partner = document.getElementById("in_partner").value
      let found = false
      for(let i = 0; i < PlayerData.partners.length; i++){
        if (Partner === PlayerData.partners[i].name){
          found = true
          AddPartner(document.getElementById("in_partner").value)
        }
      }
      if (found === false){
        AddPartner(document.getElementById("in_iban_money").value)
      }
      document.getElementById("in_partner").value = null
      document.getElementById("in_iban_money").value = null
    }
  }

  function AddNewPartner(){
    let Pname = document.getElementById("in_partner_name").value
    let Piban = IbanPrefix+document.getElementById("in_partner_iban").value
    PlayerData.partners.push({name:  Pname, iban: Piban})
    ImportPartners()

    $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"RefreshPartnerList", partnerlist:PlayerData.partners}))

    document.getElementById("in_partner_name").value = null
    document.getElementById("in_partner_iban").value = null
    CanAddPartner()
  }

  function RemovePartner(){
    let Name = document.getElementById("in_partner_name").value

    for(let i = 0; i < PlayerData.partners.length; i++){
      if (PlayerData.partners[i].name === Name){
        delete PlayerData.partners.splice(i, 1)
      }
    }

    ImportPartners()
    
    $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"RefreshPartnerList", partnerlist:PlayerData.partners}))
    
    document.getElementById("in_partner_name").value = null
    document.getElementById("in_partner_iban").value = null
    CanAddPartner()
  }

  function containsOnlyNumbers(str) {
    return /^\d+$/.test(str);
  }

  function ImportPartners(){
    TypeAheadList = []
    for(let i = 0; i < PlayerData.partners.length; i++){
      if (PlayerData.partners[i] != undefined){
        TypeAheadList.push(PlayerData.partners[i].name)
      }
    }

    var $input = $(".typeahead");

    $input.typeahead('destroy');

    $input.typeahead({
      autocomplete: true,
      source: TypeAheadList,
    });

    $input.change(function() {
        var current = $input.typeahead("getActive");
        matches = [];

        if (current) {
          if (current.name == $input.val()) {
              matches.push(current.name);
          }
        }
    });
  }

  var canSetClick = true;

  function atm_numpad(pin) {
    var input = "";
    correct = pin;

    var dots = document.querySelectorAll(".dot");
    numbers = document.querySelectorAll(".number");
    dots = Array.prototype.slice.call(dots);
    numbers = Array.prototype.slice.call(numbers);
    

    numbers.forEach(function (number, index) {
      if (canSetClick){
        number.addEventListener("click", numpad);
      }
      function numpad() {
        if (index == 9 || index == 11) {
          if (index == 9) {
            dots.forEach(function (dot, index) {
                dot.className = "dot clear";
              });
          } else if (index == 11) {
            if (input == correct) {


              dots.forEach(function (dot, index) {
                dot.className = "dot active correct";
              });

              setTimeout(function () {
                hide(".pincode_section")
                show(".main_bank")
              }, 600);

            } else {

              dots.forEach(function (dot, index) {
                dot.className = "dot active wrong";
              });
            }
          }
          setTimeout(function () {
            dots.forEach(function (dot, index) {
              dot.className = "dot";
            });
            input = "";
          }, 600);
          setTimeout(function () {
            document.body.className = "";
          }, 2000);
        } else {

          if (input.length < 4) {
            if (index == 10) {
            index = -1
          }
          input += index + 1;
          dots[input.length - 1].className = "dot active";
          }
        }
      }
    });
    canSetClick = false
  }
</script>

<style scoped>
  @import url('https://fonts.googleapis.com/css2?family=Oswald:wght@200;300;400;500;600;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Gothic+A1:wght@300&display=swap');

  body{
      font-family: 'Oswald', sans-serif;
      user-select: none;
      background: none;
  }

  :root{
      --main_color: rgba(15,210,105,255);
      --background_color: rgb(34, 34, 39);
      --secondary_color: rgb(43, 43, 49);
      --text_color: white;
      --secondarytext_color: rgb(187, 187, 187);
  }

  .sec_text{
      color: var(--secondarytext_color);
  }

  button{
      outline: none;
      border: none;
      cursor: pointer;
      transition: all 0.2s;
  }

  button:active{
      filter: brightness(70%);
  }

  button:disabled{
      opacity: 0.6;
      cursor: none;
  }

  button:disabled:active{
      filter: none;
  }

  ::-webkit-scrollbar{
      display: none;
  }

  .cards{
      transition: all 0.3s ease-in-out;
      color: var(--text_color);
      font-weight: 600;
  }

  .main_bank{
      position: absolute;
      width: 1100px;
      height: 720px;
      border-radius: 18px;
      background-color: var(--background_color);
      left: 50%;
      top: 50%;
      transform: translate(-50%, -50%);
      box-shadow: 0px 0px 15px 0px rgba(31, 32, 37, 0.7);
      overflow: hidden;
      opacity: 0;
      display: none;
  }

  .main_bank .sidebar{
      font-size: 24px;
      color: var(--secondarytext_color);
      border-radius: 14px;
      width: 200px;
      height: 100%;
      background-color: transparent;
      text-align: left;
      padding: 8px;
  }

  .main_bank .sidebar:hover{
      background-color: var(--main_color);
      color: var(--text_color);
  }

  .log_out{
      position: absolute;
      bottom: 30px;
      left: 30px;
      font-size: 24px;
      color: var(--secondarytext_color);
      border-radius: 14px;
      background-color: transparent;
      text-align: left;
      padding: 8px;
  }

  .log_out:hover{
      color: rgb(221, 27, 27);
  }

  .logo{
      height: 80px;
      width: 100%;
      border-radius: 13px;
      text-align: center;
      font-size: 32px;
      font-weight: 700;
      margin-bottom: 0px;
  }

  .logo .low{
      margin-top: -10px;
      font-size: 35px;
      font-weight: 800;
      color: var(--main_color);
  }

  hr{
      height: 2px;
      width: 100%;
      background-color: #939393;
      margin: 0;
  }

  .user{
      margin: 15px;
      margin-top: 0;
      height: 60px;
      width: 60px;
      border-radius: 100%;
      background-image: url("../src/assets/bank/m.png");
      background-color: var(--main_color);
      background-position: center;
      background-size: cover;
      float: left;
      transition: all 0.3s;
  }

  .username{
      font-size: 18px;
      float: left;
      width: 60%;
  }

  .card_bg{
      height: 200px;
      width: 333px;
      background: var(--secondary_color);
      border-radius: 13px;
  }

  .current_card{
      height: 100%;
      width: 100%;
      background-color: var(--main_color);
      background-image: url("../src/assets/bank/card_bg.png");
      background-position: right;
      background-size: 180%;
      border-radius: 13px;
      transition: all 0.25s ease-in-out;
      overflow: hidden;
  }

  .current_card .visa_logo{
      width: 90px;
      position: relative;
      float: right;
      margin-right: 10px;
      top: 80%;
  }

  .current_card .card_visa{
      font-family: 'Gothic A1', sans-serif;
      color: white;
      margin-left: 20px;
      margin-top: 20px;
      font-size: 24px;
      font-weight: 900;
  }

  .current_card .card_chip{
      width: 80px;
      position: relative;
      margin-left: 20px;
      transform: translate(0%, -50%);
      margin-top: 0%;
  }

  .current_card .wifi_logo{
      position: relative;
      color: white;
      font-size: 22px;
      margin-left: 100px;
      margin-top: 0%;
      transform: translate(0%, +50%);
  }

  .current_card .card_owner{
      font-family: 'Gothic A1', sans-serif;
      margin-top: 0%;
      color: white;
      margin-left: 20px;
      font-size: 23px;
      font-weight: 900;
  }

  .card_bg:hover .current_card{
      transform: translate(6.5%, -6%);
  }

  .card_bg:active .current_card{
      transition: all 0.05s ease-in-out;
      transform: translate(5%, -5%);
  }

  .balance{
      font-size: 33px;
      color: var(--text_color);
  }

  .card_infos{
      color: var(--secondarytext_color);
  }

  .transaction_btn{
      font-size: 24px;
      color: white;
      border-radius: 14px;
      height: 50px;
      background: var(--main_color);
      font-weight: 600;
  }

  .tran_menu_btn{
      font-size: 30px;
      color: white;
      border-radius: 14px;
      height: 75px;
      background: var(--main_color);
      font-weight: 600;
  }

  .payment_btn{
      font-size: 24px;
      color: white;
      border-radius: 11px;
      height: 40px;
      background: var(--main_color);
      font-weight: 500;
      z-index: 2;
  }

  .main_bank .analytics{
      height: 260px;
      background: var(--secondary_color);
      border-radius: 13px;
  }

  .main_bank .payments{
      height: 355px;
      background: var(--secondary_color);
      border-radius: 13px;
  }

  .modal-content{
      background: var(--secondary_color);
      border-radius: 13px;
      color: var(--text_color);
  }

  .payments_con table{
      background: transparent;
      color: var(--text_color);
      margin: 0;
  }

  .payments_con table .amount{
      width: 25%;
      font-size: 18px;
      text-align: center;
      color: rgb(40, 174, 31);
  }

  .payments_con table .type{
      width: 15%;
      text-align: center;
  }

  .payments_con table .name{
      width: 30%;
      text-align: center;
  }

  .payments_con table .action{
      width: 30%;
      color: var(--main_color);
      text-align: center;
  }

  .payments_con .table_header{
      background: var(--background_color);
      border-radius: 8px;
      width: 95%;
      margin-left: 2.5%;
      margin-bottom: 5px;
      margin-top: 20px;
  }

  .payments_con .table_header th{
      color: rgb(169, 169, 169);
      font-size: 17px;
  }

  .payments .payments_con .table_container{
      overflow: hidden;
      max-height: 290px;
  }

  .payments_con .table_element{
      margin-top: 8px;
      width: 95%;
      padding-top: 2.2px;
      padding-bottom: 2.2px;
      margin-left: 2.5%;
      font-size: 20px;
      background-color: var(--background_color);
      border-radius: 10px;
      color: var(--text_color);
      transition: all 0.1s ;
  }

  .custom-control.ios-switch {
      padding-left: 0;
      scale: 1.8;
  }

  .custom-control.ios-switch .ios-switch-control-input {
      display: none;
  }

  .custom-control.ios-switch .ios-switch-control-input:active~.ios-switch-control-indicator::after {
      width: 20px;
  }

  .custom-control.ios-switch .ios-switch-control-input:checked~.ios-switch-control-indicator {
      border: 10px solid var(--main_color);
      background:var(--main_color);
  }

  .custom-control.ios-switch .ios-switch-control-input:checked~.ios-switch-control-indicator::after {
      top: -8px;
      left: 8px;
  }

  .custom-control.ios-switch .ios-switch-control-input:checked:active~.ios-switch-control-indicator::after {
      left: 0px;
  }

  .custom-control.ios-switch .ios-switch-control-indicator {
      display: inline-block;
      position: relative;
      margin: 0 10px;
      top: 4px;
      width: 36px;
      height: 20px;
      background: rgb(242,241,246);
      border-radius: 16px;
      transition: 0.3s;
      border: 2px solid #ddd;
  }

  .custom-control.ios-switch .ios-switch-control-indicator::after {
      content: '';
      display: block;
      position: absolute;
      width: 16px;
      height: 16px;
      border-radius: 16px;
      transition: 0.3s;
      top: 0px;
      left: 0px;
      background: white;
      box-shadow: 0 0 2px #aaa, 0 2px 5px #999;
  }

  .theme_btn{
      height: 40px;
      width: 40px;
      border-radius: 100%;
      border: solid 2px gray;
      background-color: white;
  }

  .color_btn{
      height: 40px;
      width: 40px;
      border-radius: 100%;
      border: none;
  }

  .color_btn i{
      color: white;
      font-size: 25px;
      margin: 0;
  }

  .settings_element{
      background-color: var(--secondary_color);
      border-radius: 14px;
  }

  .addmember_element{
      background-color: var(--background_color);
      border-radius: 14px;
      margin-bottom: 15px;
  }

  .input-group input{
      background-color: var(--background_color);
      color: var(--text_color);
      border: none;
      outline: none;
  }

  .input-group input::placeholder{
      color: var(--text_color);
  }

  .input-group input:focus{
      background-color: var(--background_color);
      color: var(--text_color);
      box-shadow: 0px 0px 0px 3px var(--main_color);
  }

  .input-group input::placeholder {
      color: var(--secondarytext_color);
  }

  .chart-container{
      height: 220px;
      width: 400px;
  }

  .per_table_container .input-group input{
      background-color: var(--secondary_color);
      color: var(--text_color);
      border: none;
      outline: none;
  }

  .del:disabled{
      opacity: 0.6;
  }

  .balance_block{
      height: 10px;
      width: 30px;
      background-color: var(--main_color);
      border-radius: 10px;
  }

  .range::-webkit-slider-thumb{
      -webkit-appearance: none;
      appearance: none;
      height: 20px;
      width: 20px;
      border-radius: 100%;
      background: var(--main_color);
      cursor: pointer;
      box-shadow: none;
      outline: none;
      transition: 0.3s;
  }

  .range::-webkit-slider-thumb:focus{
      height: 25px;
      width: 25px;
  }

  .range{
      -webkit-appearance: none;
      width: 75%;
      height: 13px;
      border-radius: 10px;
      outline: none;
      background-color: var(--background_color);
  }

  .addmember_element .range{
      -webkit-appearance: none;
      background-color: var(--secondary_color);
  }

  .partners_container{
      width: 100%;
      min-height: 50px;
      border-radius: 10px;
      background-color: var(--background_color);
      display: inline-block;
      -webkit-animation: growpartner 0.6s ease-in-out;
    animation: growpartner 0.6s ease-in-out;
  }

  @keyframes growpartner {
      0% {
      width: 0%;
    }
      100%{
          width: 100%;
      }
  }

  .partners_container .partner_element{ 
      float: left;
      margin: 8px;
      padding: 4px;
      width: fit-content;
      font-size: 20px;
      border-radius: 5px;
      background-color: var(--secondary_color);
  }

  .remove_partner_btn{
      font-size: 15px;
      background-color: transparent;
      color: var(--text_color);
      margin-left: 3px;
  }

  .remove_partner_btn:hover{
      color: red;
  }

  .dropdown .dropdown-menu{
      background-color: var(--background_color);
  }

  .dropdown .dropdown-menu .dropdown-item{
      color: var(--text_color);
  }

  .dropdown .dropdown-menu .dropdown-item:hover{
      background-color: var(--secondary_color);
  }

  .typeahead + .dropdown-menu{
      margin-top: 10px;
      background-color: var(--background_color);
      color: var(--text_color);
      border: solid 2px var(--main_color);
  }

  .typeahead + .dropdown-menu a{
      background-color: var(--background_color);
      color: var(--text_color);
  }

  .typeahead + .dropdown-menu .active > a:hover {
      background-color: var(--secondary_color);
  }

  .pincode_section{
      position: absolute;
    width: 450px;
      height: 650px;
    border-radius: 18px;
    background-color: var(--background_color);
      color: var(--text_color);
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    box-shadow: 0px 0px 15px 0px rgba(31, 32, 37, 0.7);
      overflow: hidden;
      opacity: 0;
      display: none;
      transition: all 0.3s ease-in-out;
  }

  .dots{
    width: 50%;
    justify-content: space-around;
    padding: 1em;
    padding-top: 2em;
  }

  .dot{
    position: relative;
    background: rgba(143, 144, 148, 0.5);
    border-radius: 50%;
    width: 1.9em;
    height: 1.9em;
  }

  .dot.active{
    -webkit-animation: growDot 0.3s ease-in-out;
    animation: growDot 0.3s ease-in-out;
    -webkit-animation-fill-mode: forwards;
    animation-fill-mode: forwards;
  }

  .dot.wrong{
    -webkit-animation: wrong 0.6s ease-in-out;
    animation: wrong 0.6s ease-in-out;
  }

  .dot.correct{
    -webkit-animation: correct 0.6s ease-in-out;
    animation: correct 0.6s ease-in-out;
  }

  .dot.clear{
    -webkit-animation: clear 0.6s ease-in-out;
    animation: clear 0.6s ease-in-out;
  }

  .number{
      height: 2.5em;
      width: 2.5em;
      border-radius: 50%;
      background-color: transparent;
      color: var(--text_color);
      transition: all 0.2s;
      text-align: center;
      font-size: 40px;
      font-weight: 700;
      text-align: center;
    line-height: 2.5em;
  }

  .number:hover{
      background-color: var(--secondary_color);
      cursor: pointer;
  }

  .number:active{
      background-color: var(--main_color);
  }

  @keyframes growDot {
    100% {
      background: var(--text_color);
      transform: scale(1.1);
    }
  }

  @keyframes wrong {
    20% {
      background: rgb(255, 0, 0);
      transform: scale(1.1);
      left: 0px;
    }
    40% {
      left: -5px;
    }
    60% {
      left: 10px;
    }
    80% {
      left: -5px;
    }
  }

  @keyframes correct {
    20% {
      background: rgb(30, 188, 98);
      transform: scale(1.1);
    }
  }

  @keyframes clear {
      0%{
          background: var(--text_color);
      }
    20% {
      transform: scale(1.1);
    }
  }
</style>