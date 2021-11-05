//
//  DataBackupViewController.swift
//  SSAC_ShoppingList
//
//  Created by 최혜린 on 2021/11/05.
//

import UIKit
import RealmSwift
import Zip
import MobileCoreServices

class DataBackupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "백업/복구"
    }
    @IBAction func backupButtonTapped(_ sender: UIButton) {
        detectEnoughSpaceLeft()
    }
    
    @IBAction func restoreButtonTapped(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    func detectEnoughSpaceLeft() // return free space in MB
        {
            var totalFreeSpaceInBytes: CLongLong = 0; //total free space in bytes

            do{
                let spaceFree: CLongLong = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())[FileAttributeKey.systemFreeSize] as! CLongLong;
                totalFreeSpaceInBytes = spaceFree;

            }catch let error{ // Catch error that may be thrown by FileManager
                print("Error is ", error);
            }

            let totalBytes: CLongLong = 1 * CLongLong(totalFreeSpaceInBytes);
            let totalMb: CLongLong = totalBytes / (1024 * 1024);
            
            // 200메가바이트도 안남아있는 경우에는 저장공간 부족하다고 alert 띄우기
            // 저장공간 넉넉하면 backup 진행
            if totalMb < 200 {
                showAlert("저장 공간이 부족합니다.", "200MB 이상의 저장 공간을 확보해주세요.")
            } else {
                backupFile()
            }
        }
    
    // Document 폴더 위치 찾아서 return 해주는 메서드
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
    }
    
    func backupFile() {
        var urlPaths = [URL]()
        
        if let path = documentDirectoryPath() {
            let realm = (path as NSString).appendingPathComponent("default.realm")
            if FileManager.default.fileExists(atPath: realm) {
                urlPaths.append(URL(string: realm)!)
            } else {
                showAlert("백업할 파일이 없습니다")
            }
        }
        
        do {
            view.isUserInteractionEnabled = false
            try Zip.quickZipFiles(urlPaths, fileName: "archive")
            view.isUserInteractionEnabled = true
            showAlert("주의사항", "반드시 파일 앱에 데이터를 저장해주세요!", {_ in self.presentActivityViewController()})
        } catch {
            showAlert("에러가 발생했습니다.")
        }
    }
    
    func presentActivityViewController() {
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion:nil)
    }
}

extension DataBackupViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {return}
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")

                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    self.showAlert("복구가 완료되었습니다.", "앱을 재실행시켜주세요.")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            } catch {
                showAlert("복구를 실패했습니다.")
            }
        } else {
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")

                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            } catch {
                showAlert("복구를 실패했습니다.")
            }
        }
            
    }
}
