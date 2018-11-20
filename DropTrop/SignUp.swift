//
//  SignUp.swift
//  DropTrop
//
//  Created by 道添　竜平 on 2018/11/06.
//  Copyright © 2018 道添　竜平. All rights reserved.
//

import Foundation
import UIKit

class SignUp: UIViewController {
    private var text1 = UILabel()
    private var name = UITextField()
    private var password = UITextField()
    private var DataPicker = CustomDatePicker()
    private var gender = UIPickerView()
    private var prefecture = UIPickerView()
    private var genField = UITextField()
    private var preField = UITextField()
    var genId:Int! = nil
    var preId:Int! = nil
    private var signUpBtn = CustomButton()
    private var url = "https://droptrop.com/a/login/mobile"
    let preList = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県","茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県","新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県","静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県","徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    let genList = ["男性","女性"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        /*let scrollView = UIScrollView()
        let arrText1 = NSMutableAttributedString(string: "必要情報を入力してください\n※が付いたものは必須です")
        arrText1.addAttribute(.foregroundColor, value: theme_color, range:NSMakeRange(16,15) )
        text1.frame = CGRect(x:viewWidth*0.3, y:viewHeight*0.1, width:viewWidth*0.4,height:viewHeight*0.2);
        text1.numberOfLines = 0
        //text1.text = "test\ntest"
        text1.attributedText = arrText1
 
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width:viewWidth, height:viewHeight*2)
        scrollView.addSubview(text1)
        view.addSubview(scrollView)
        */
        
        //名前とパスワード
        name.frame = CGRect(x:viewWidth*0.3,y:viewHeight*0.1,width:viewWidth*0.4,height:viewHeight*0.05)
        name.borderStyle  = .roundedRect
        self.name.autocapitalizationType = UITextAutocapitalizationType.none;
        password.frame = CGRect(x:viewWidth*0.3,y:viewHeight*0.2,width:viewWidth*0.4,height:viewHeight*0.05)
        password.borderStyle = .roundedRect
        self.password.autocapitalizationType = UITextAutocapitalizationType.none;
        //誕生日選択view
        DataPicker.frame = CGRect(x:viewWidth*0.3,y:viewHeight*0.3,width:viewWidth*0.4,height:viewHeight*0.05)
        DataPicker.borderStyle = .roundedRect
        
        //性別確認view
        genField.frame = CGRect(x:viewWidth*0.3,y:viewHeight*0.4,width:viewWidth*0.4,height:viewHeight*0.05)
        genField.borderStyle = .roundedRect
        gender.frame = CGRect(x:0,y:0,width:viewWidth*0.3,height:viewHeight*0.3)
        gender.showsSelectionIndicator = true
        
        gender.delegate = self
        gender.dataSource = self
        gender.showsSelectionIndicator = true
        gender.tag = 1
        
        let toolbar = UIToolbar(frame:CGRect(x:0,y:0,width:viewWidth,height:35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        genField.inputView = gender
        genField.inputAccessoryView = toolbar
        
        //都道府県選択view
        preField.frame = CGRect(x:viewWidth*0.3,y:viewHeight*0.5,width:viewWidth*0.4,height:viewHeight*0.05)
        preField.borderStyle = .roundedRect
        prefecture.frame = CGRect(x:0,y:0,width:viewWidth*0.3,height:viewHeight*0.3)
        prefecture.showsSelectionIndicator = true
        
        prefecture.delegate = self
        prefecture.dataSource = self
        prefecture.showsSelectionIndicator = true
        prefecture.tag = 2
        
        let toolBarPre = UIToolbar(frame:CGRect(x:0,y:0,width:viewWidth,height:35))
        let spaceItemPre = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItemPre = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePre))
        toolBarPre.setItems([spaceItemPre,doneItemPre], animated: true)
        preField.inputView = prefecture
        preField.inputAccessoryView = toolBarPre
        
        //新規登録完了ボタン
        signUpBtn.setTitle("SignUp",for: .normal)
        signUpBtn.backgroundColor = theme_color
        signUpBtn.frame = CGRect(x: viewWidth*0.3,y:viewHeight * 0.6,width: viewWidth*0.4,height: viewHeight*0.05)
        signUpBtn.addTarget(self,action:#selector(SignUp.signUpTapped(sender:)),for:.touchUpInside)
        
        view.addSubview(signUpBtn)
        view.addSubview(DataPicker)
        view.addSubview(name)
        view.addSubview(password)
        view.addSubview(genField)
        view.addSubview(preField)
        
        
        
    }
    //pickerのDoneが押された時の動作
    @objc func done(sender:UIBarButtonItem){
        genField.endEditing(true)
        genField.text = "\(genList[gender.selectedRow(inComponent: 0)])"
        genId = gender.selectedRow(inComponent: 0)+1
    }
    
    @objc func donePre(sender:UIBarButtonItem){
        preField.endEditing(true)
        preField.text = "\(preList[prefecture.selectedRow(inComponent: 0)])"
        preId = prefecture.selectedRow(inComponent: 0)+1
    }
    //signUpボタンタップ時の動作
    @objc func signUpTapped(sender:AnyObject){
        var person = Dictionary<String,Any>()
        
        //jsonを入力
        if name.text != nil {
            person["name"] = name.text
        }
        if password.text != nil {
            person["password"] = password.text
        }
        if DataPicker.getDate() != nil {
            let format = DateFormatter()
            format.dateFormat = "yyyyMMdd"
            person["birthday"] = format.string(from: DataPicker.getDate())
        }
        if genId != nil {
            person["gender"] = genId
        }
        if preId != nil{
            person["prefecture"] = preId
        }
        
        //Postメソッド
        var request = URLRequest(url: URL(string:url)!)
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField:"Content-Type")
        
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: person, options:[])
            let jsonStr = String(bytes:jsonData, encoding: .utf8)!
            request.httpBody=jsonStr.data(using: .utf8)
            print(jsonStr)
            
        }catch{
            print(error.localizedDescription)
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            if (error == nil) {
                let result = String(data: data!, encoding: .utf8)!
                print(result)
            } else {
                print(error)
            }
        })
        task.resume()
        
    }
    
        
    }

    

extension SignUp:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return genList.count
        }else{
            return preList.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return genList[row]
        }else{
            return preList[row]
        }
    }
    
}

