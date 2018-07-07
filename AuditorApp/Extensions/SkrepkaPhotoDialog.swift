import UIKit

class SkrepkaPhotoDialog: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{
    
    var currentQuestion : Model_Question!
    
    let gh = GlobalHelper.sharedInstance
    let gc = GlobalClass.sharedInstance
    var currentImagesArray : [UIImage] = []
    
    var dialogWidth : CGFloat!
    
    var viewWidth : CGFloat!
    var viewHeight : CGFloat!
    
    var flowWidth : CGFloat!
    var flowHeight : CGFloat!
    
    var collView : UICollectionView!
    
    let cellID = "cellId"
    
    var btnGallery : myGalleryButton!
    var btnCamera : myCameraButton!
    
    var fullHeight : CGFloat!
    
    var viewForImages : myAuditView!
   
    
    func customInit()
    {
        
        for img in currentQuestion.addedImages
        {
            currentImagesArray.append(img)
        }
        
        let previousArray = currentQuestion.addedImages
        
        currentQuestion.addedImages.removeAll()
        
        let photoV = currentQuestion.photoView!
        let rootView = currentQuestion.auditView!
        let rootHeight = rootView.frame.size.height
        let photoHeight = photoV.frame.size.height
        
        for child in photoV.subviews
        {
            child.removeFromSuperview()
        }
        
        let photoViewCons = photoV.constraints.filter
        {
            $0.firstAttribute == NSLayoutAttribute.height
        }
        NSLayoutConstraint.deactivate(photoViewCons)
        
        photoV.heightAnchor.constraint(equalToConstant: 0).isActive = true
        photoV.layoutIfNeeded()
        
        let rootCons = rootView.constraints.filter
        {
            $0.firstAttribute == NSLayoutAttribute.height
        }
        NSLayoutConstraint.deactivate(rootCons)
        
        rootView.heightAnchor.constraint(equalToConstant: rootHeight - photoHeight).isActive = true
        rootView.layoutIfNeeded()
        
        
        
        self.modalPresentationStyle = .overCurrentContext
        view.backgroundColor = UIColor.clear
        
        
        let darkView = UIView()
        darkView.backgroundColor = UIColor.black
        darkView.alpha = 0.8
        darkView.frame = view.bounds
        darkView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(darkView)
        
        let dialogView = myAuditView()
        view.insertSubview(dialogView, at: 1)
        
        dialogView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dialogView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        dialogView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9, constant: 0).isActive = true
        dialogView.heightAnchor.constraint(equalToConstant: 388).isActive = true
        dialogView.layoutIfNeeded()
        
        let header = UILabel()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = gh.myRed
        header.clipsToBounds = true
        header.layer.cornerRadius = 6
        header.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        header.text = "Добавить изображения"
        header.font = gh.globalFont18
        header.textAlignment = .center
        header.textColor = gh.myBejColor
        
        dialogView.addSubview(header)
        header.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 0).isActive = true
        header.heightAnchor.constraint(equalToConstant: 36).isActive = true
        header.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1).isActive = true
        header.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor, constant: 0).isActive = true
        header.layoutIfNeeded()
        
        viewForImages = myAuditView()
        dialogView.addSubview(viewForImages)
        
        dialogWidth = dialogView.frame.size.width
        
        flowWidth = dialogWidth - 4
        flowHeight = (flowWidth / 4) * (1.78 * 2)
        
        viewWidth = dialogWidth - 12
        //viewHeight = (viewWidth * 1.78 * 2) + 44
        viewHeight = (viewWidth / 2) * 1.78 + 44
        
        flowWidth = viewWidth - 8
        flowHeight = (flowWidth / 4) * (1.78 * 2)
        
        viewForImages.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        viewForImages.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
        viewForImages.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 4).isActive = true
        viewForImages.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor, constant: 0).isActive = true
        viewForImages.layoutIfNeeded()
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        //let flowLyaout = UICollectionViewFlowLayout.init()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = CGFloat(0.0)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        collView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        viewForImages.addSubview(collView)
        collView.translatesAutoresizingMaskIntoConstraints = false
        collView.backgroundColor = UIColor.clear
        
        collView.widthAnchor.constraint(equalTo: viewForImages.widthAnchor, multiplier: 1, constant: -8).isActive = true
        collView.topAnchor.constraint(equalTo: viewForImages.topAnchor, constant: 4).isActive = true
        collView.centerXAnchor.constraint(equalTo: viewForImages.centerXAnchor).isActive = true
        //collView.heightAnchor.constraint(equalTo: viewForImages.heightAnchor, multiplier: 1, constant: -44).isActive = true
        collView.heightAnchor.constraint(equalToConstant: flowHeight).isActive = true
        
        collView.delegate = self
        collView.dataSource = self
        
        collView.register(customCell.self, forCellWithReuseIdentifier: cellID)
        
        collView.isScrollEnabled = false
        
        btnGallery = myGalleryButton()
        viewForImages.addSubview(btnGallery)
        
        btnGallery.widthAnchor.constraint(equalTo: viewForImages.widthAnchor, multiplier: 0.5, constant: -6).isActive = true
        btnGallery.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btnGallery.bottomAnchor.constraint(equalTo: viewForImages.bottomAnchor, constant: -4).isActive = true
        btnGallery.leftAnchor.constraint(equalTo: viewForImages.leftAnchor, constant: 4).isActive = true
        btnGallery.layoutIfNeeded()
        
        
        btnCamera = myCameraButton()
        viewForImages.addSubview(btnCamera)
        
        btnCamera.widthAnchor.constraint(equalTo: viewForImages.widthAnchor, multiplier: 0.5, constant: -6).isActive = true
        btnCamera.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btnCamera.bottomAnchor.constraint(equalTo: viewForImages.bottomAnchor, constant: -4).isActive = true
        btnCamera.rightAnchor.constraint(equalTo: viewForImages.rightAnchor, constant: -4).isActive = true
        btnCamera.layoutIfNeeded()
        
        btnGallery.click =
            {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                
                self.present(imagePicker, animated: false, completion: nil)
            }
        
        btnCamera.click =
            {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                
                self.present(imagePicker, animated: false, completion: nil)
            }
        
        
        
        if btnCamera.frame.size.width < 140
        {
            btnCamera.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        }
        
        if btnGallery.frame.size.width < 140
        {
            btnGallery.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        }
        
        let okButton = redButton()
        dialogView.addSubview(okButton)
        okButton.setTitle("Сохранить", for: .normal)
        
        okButton.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5, constant: -9).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        okButton.topAnchor.constraint(equalTo: viewForImages.bottomAnchor, constant: 12).isActive = true
        okButton.rightAnchor.constraint(equalTo: dialogView.rightAnchor, constant: -6).isActive = true
        okButton.layoutIfNeeded()
        
        let cancelButton = transButton()
        dialogView.addSubview(cancelButton)
        cancelButton.setTitle("Отмена", for: .normal)
        
        cancelButton.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5, constant: -9).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        cancelButton.topAnchor.constraint(equalTo: viewForImages.bottomAnchor, constant: 12).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: 6).isActive = true
        cancelButton.layoutIfNeeded()
        
        
        
        fullHeight = header.frame.size.height + viewForImages.frame.size.height + 36 + 24
        
        let cons = dialogView.constraints.filter
        {
            $0.firstAttribute == NSLayoutAttribute.height
        }
        NSLayoutConstraint.deactivate(cons)
        
        dialogView.heightAnchor.constraint(equalToConstant: fullHeight).isActive = true
        
        
        cancelButton.click =
            {
                self.currentImagesArray = previousArray
                okButton.click?()
            }
        
        okButton.click =
            {
                if self.currentImagesArray.count == 0
                {
                    
                    self.dismiss(animated: true, completion: nil)
                    return
                }
                
                let rootView = self.currentQuestion.auditView!
                //let rootCurrentHeight = rootView.frame.size.height
                let rootWidth = rootView.frame.size.width
                let photoViewWidth = rootWidth - 12
                let eachPhotowidth = (photoViewWidth - 20) / 4
                let eachPhotoHeight = eachPhotowidth * 1.7
                
                let viewForPhoto = self.currentQuestion.photoView!
                
                
                var img0 : UIImageView!
                var img1 : UIImageView!
                var img2 : UIImageView!
                var img3 : UIImageView!
                var img4 : UIImageView!
                var img5 : UIImageView!
                var img6 : UIImageView!
                var img7 : UIImageView!
                
                
                
                if self.currentImagesArray.count > 0
                {
                    img0 = UIImageView()
                    img0.contentMode = .scaleAspectFill
                    img0.translatesAutoresizingMaskIntoConstraints = false
                    img0.image = self.currentImagesArray[0]
                    img0.layer.borderWidth = 0
                    img0.layer.borderColor = self.gh.myRed.cgColor
                    img0.clipsToBounds = true
                    
                    viewForPhoto.addSubview(img0)
                    
                    img0.widthAnchor.constraint(equalToConstant: eachPhotowidth).isActive = true
                    img0.heightAnchor.constraint(equalToConstant: eachPhotoHeight).isActive = true
                    img0.topAnchor.constraint(equalTo: viewForPhoto.topAnchor, constant: 4).isActive = true
                    img0.leftAnchor.constraint(equalTo: viewForPhoto.leftAnchor, constant: 4).isActive = true
                    img0.layoutIfNeeded()
                }
                
                if self.currentImagesArray.count > 1
                {
                    img1 = UIImageView()
                    img1.contentMode = .scaleAspectFill
                    img1.translatesAutoresizingMaskIntoConstraints = false
                    img1.image = self.currentImagesArray[1]
                    img1.layer.borderWidth = 0
                    img1.layer.borderColor = self.gh.myRed.cgColor
                    img1.clipsToBounds = true
                    
                    viewForPhoto.addSubview(img1)
                    
                    img1.widthAnchor.constraint(equalToConstant: eachPhotowidth).isActive = true
                    img1.heightAnchor.constraint(equalToConstant: eachPhotoHeight).isActive = true
                    img1.topAnchor.constraint(equalTo: viewForPhoto.topAnchor, constant: 4).isActive = true
                    img1.leftAnchor.constraint(equalTo: img0.rightAnchor, constant: 4).isActive = true
                    img1.layoutIfNeeded()
                }
                
                if self.currentImagesArray.count > 2
                {
                    img2 = UIImageView()
                    img2.contentMode = .scaleAspectFill
                    img2.translatesAutoresizingMaskIntoConstraints = false
                    img2.image = self.currentImagesArray[2]
                    img2.layer.borderWidth = 0
                    img2.layer.borderColor = self.gh.myRed.cgColor
                    img2.clipsToBounds = true
                    
                    viewForPhoto.addSubview(img2)
                    
                    img2.widthAnchor.constraint(equalToConstant: eachPhotowidth).isActive = true
                    img2.heightAnchor.constraint(equalToConstant: eachPhotoHeight).isActive = true
                    img2.topAnchor.constraint(equalTo: viewForPhoto.topAnchor, constant: 4).isActive = true
                    img2.leftAnchor.constraint(equalTo: img1.rightAnchor, constant: 4).isActive = true
                    img2.layoutIfNeeded()
                }
                
                if self.currentImagesArray.count > 3
                {
                    img3 = UIImageView()
                    img3.contentMode = .scaleAspectFill
                    img3.translatesAutoresizingMaskIntoConstraints = false
                    img3.image = self.currentImagesArray[3]
                    img3.layer.borderWidth = 0
                    img3.layer.borderColor = self.gh.myRed.cgColor
                    img3.clipsToBounds = true
                    
                    viewForPhoto.addSubview(img3)
                    
                    img3.widthAnchor.constraint(equalToConstant: eachPhotowidth).isActive = true
                    img3.heightAnchor.constraint(equalToConstant: eachPhotoHeight).isActive = true
                    img3.topAnchor.constraint(equalTo: viewForPhoto.topAnchor, constant: 4).isActive = true
                    img3.leftAnchor.constraint(equalTo: img2.rightAnchor, constant: 4).isActive = true
                    img3.layoutIfNeeded()
                }
                
                if self.currentImagesArray.count > 4
                {
                    img4 = UIImageView()
                    img4.contentMode = .scaleAspectFill
                    img4.translatesAutoresizingMaskIntoConstraints = false
                    img4.image = self.currentImagesArray[4]
                    img4.layer.borderWidth = 0
                    img4.layer.borderColor = self.gh.myRed.cgColor
                    img4.clipsToBounds = true
                    
                    viewForPhoto.addSubview(img4)
                    
                    img4.widthAnchor.constraint(equalToConstant: eachPhotowidth).isActive = true
                    img4.heightAnchor.constraint(equalToConstant: eachPhotoHeight).isActive = true
                    img4.topAnchor.constraint(equalTo: img0.bottomAnchor, constant: 4).isActive = true
                    img4.leftAnchor.constraint(equalTo: viewForPhoto.leftAnchor, constant: 4).isActive = true
                    img4.layoutIfNeeded()
                }
                
                if self.currentImagesArray.count > 5
                {
                    img5 = UIImageView()
                    img5.contentMode = .scaleAspectFill
                    img5.translatesAutoresizingMaskIntoConstraints = false
                    img5.image = self.currentImagesArray[5]
                    img5.layer.borderWidth = 0
                    img5.layer.borderColor = self.gh.myRed.cgColor
                    img5.clipsToBounds = true
                    
                    viewForPhoto.addSubview(img5)
                    
                    img5.widthAnchor.constraint(equalToConstant: eachPhotowidth).isActive = true
                    img5.heightAnchor.constraint(equalToConstant: eachPhotoHeight).isActive = true
                    img5.topAnchor.constraint(equalTo: img0.bottomAnchor, constant: 4).isActive = true
                    img5.leftAnchor.constraint(equalTo: img4.rightAnchor, constant: 4).isActive = true
                    img5.layoutIfNeeded()
                }
                
                if self.currentImagesArray.count > 6
                {
                    img6 = UIImageView()
                    img6.contentMode = .scaleAspectFill
                    img6.translatesAutoresizingMaskIntoConstraints = false
                    img6.image = self.currentImagesArray[6]
                    img6.layer.borderWidth = 0
                    img6.layer.borderColor = self.gh.myRed.cgColor
                    img6.clipsToBounds = true
                    
                    viewForPhoto.addSubview(img6)
                    
                    img6.widthAnchor.constraint(equalToConstant: eachPhotowidth).isActive = true
                    img6.heightAnchor.constraint(equalToConstant: eachPhotoHeight).isActive = true
                    img6.topAnchor.constraint(equalTo: img0.bottomAnchor, constant: 4).isActive = true
                    img6.leftAnchor.constraint(equalTo: img5.rightAnchor, constant: 4).isActive = true
                    img6.layoutIfNeeded()
                }
                
                if self.currentImagesArray.count > 7
                {
                    img7 = UIImageView()
                    img7.contentMode = .scaleAspectFill
                    img7.translatesAutoresizingMaskIntoConstraints = false
                    img7.image = self.currentImagesArray[7]
                    img7.layer.borderWidth = 0
                    img7.layer.borderColor = self.gh.myRed.cgColor
                    img7.clipsToBounds = true
                    
                    viewForPhoto.addSubview(img7)
                    
                    img7.widthAnchor.constraint(equalToConstant: eachPhotowidth).isActive = true
                    img7.heightAnchor.constraint(equalToConstant: eachPhotoHeight).isActive = true
                    img7.topAnchor.constraint(equalTo: img0.bottomAnchor, constant: 4).isActive = true
                    img7.leftAnchor.constraint(equalTo: img6.rightAnchor, constant: 4).isActive = true
                    img7.layoutIfNeeded()
                }
                
                let photoViewCons = viewForPhoto.constraints.filter
                {
                    $0.firstAttribute == NSLayoutAttribute.height
                }
                NSLayoutConstraint.deactivate(photoViewCons)
                
                if self.currentImagesArray.count <= 4
                {
                    viewForPhoto.heightAnchor.constraint(equalToConstant: eachPhotoHeight + 8).isActive = true
                }
                else if self.currentImagesArray.count > 4
                {
                    viewForPhoto.heightAnchor.constraint(equalToConstant: (eachPhotoHeight * 2) + 12).isActive = true
                }
                
                viewForPhoto.layoutIfNeeded()
                let rootCurrentHeight = rootView.frame.size.height
                let currentViewForPhotoHeight = viewForPhoto.frame.size.height
                
                if self.currentQuestion.addedImages.count == 0
                {
                    let cons = rootView.constraints.filter
                    {
                         $0.firstAttribute == NSLayoutAttribute.height
                    }
                    NSLayoutConstraint.deactivate(cons)
                    
                    rootView.heightAnchor.constraint(equalToConstant: rootCurrentHeight + currentViewForPhotoHeight).isActive = true
                }
                
                self.currentQuestion.addedImages = self.currentImagesArray                
                self.dismiss(animated: true, completion: nil)
                
                self.gc.shablonInWork.recountScrollSize()
            }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        var cusCell = cell as! customCell
        let arrayCount = currentImagesArray.count
        if indexPath.row < arrayCount
        {
            cusCell.imgV.layer.borderWidth = 0
            cusCell.imgV.clipsToBounds = true
            cusCell.imgV.contentMode = .scaleAspectFill
            cusCell.imgV.image = currentImagesArray[indexPath.row]
            cusCell.btnRemove.isHidden = false
        }
        else
        {
            cusCell.imgV.layer.borderWidth = 1
            cusCell.imgV.image = UIImage(named: "ic_def_image")
            cusCell.btnRemove.isHidden = true
        }
        
        cusCell.btnRemove.click =
            {
                self.currentImagesArray.remove(at: indexPath.row)
                collectionView.reloadData()
                
                self.btnCamera.isEnabled = true
                self.btnGallery.isEnabled = true
                
                self.btnCamera.backgroundColor = self.gh.myRed
                self.btnGallery.backgroundColor = self.gh.myRed
            }

        print(indexPath.row)
        
        return cusCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (flowWidth/4)
        let height = (width * 1.78)
        return CGSize(width: width, height: height)
    }
    


    class customCell : UICollectionViewCell
    {
        let gh = GlobalHelper.sharedInstance
        var imgV : UIImageView!
        var btnRemove : myRemoveButton!
        
        func customInit()
        {
            imgV = UIImageView(image: UIImage(named: "ic_def_image"))
            imgV.contentMode = .scaleAspectFit
            imgV.translatesAutoresizingMaskIntoConstraints = false
            imgV.layer.borderWidth = 1
            imgV.layer.borderColor = gh.myRed.cgColor
            
            
            addSubview(imgV)
            imgV.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.96).isActive = true
            imgV.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.96).isActive = true
            imgV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            imgV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            imgV.layoutIfNeeded()
            
            btnRemove = myRemoveButton()
            btnRemove.layer.cornerRadius = 9
            addSubview(btnRemove)
            
            btnRemove.widthAnchor.constraint(equalToConstant: 18).isActive = true
            btnRemove.heightAnchor.constraint(equalToConstant: 18).isActive = true
            btnRemove.rightAnchor.constraint(equalTo: imgV.rightAnchor).isActive = true
            btnRemove.topAnchor.constraint(equalTo: imgV.topAnchor).isActive = true
            
        }
        
        override init(frame: CGRect)
        {
            super.init(frame: frame)
            customInit()
        }
        
        required init?(coder aDecoder: NSCoder)
        {
            super.init(coder: aDecoder)
            customInit()
        }
        
    }
    
    
    init(quest : Model_Question)
    {
        super.init(nibName: nil, bundle: nil)
        currentQuestion = quest
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            currentImagesArray.append(image)
            collView.reloadData()
        }
        
        if currentImagesArray.count == 8
        {
            btnCamera.isEnabled = false
            btnGallery.isEnabled = false
            
            btnCamera.backgroundColor = gh.myRedTrans
            btnGallery.backgroundColor = gh.myRedTrans
        }
        else
        {
            btnCamera.isEnabled = true
            btnGallery.isEnabled = true
            
            btnCamera.backgroundColor = gh.myRed
            btnGallery.backgroundColor = gh.myRed
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    

}
