//
//  Shell.swift
//  uploadIPA
//
//  Created by Jason on 2018/11/5.
//  Copyright © 2018 Jason. All rights reserved.
//  用来执行cmd 指令的模块

import Foundation

struct Shell {
    /* 用于执行指令操作的封装
     * cmd : 需要执行的命令
     * arguments : 执行命令的参数
     * return : 命令执行后的结果字符串
     */
    static func execmd(_ cmd: String, arguments:[String]) -> String {
        
        let task = Process()
        
        // 1. 设置命令的参数
        task.arguments = arguments
        // 2. 设置执行命令
        task.launchPath = cmd
        
        // 3. 设置命令执行后的接收管道
        let output = Pipe()
        task.standardOutput = output
        
        // 开始执行
        task.launch()
        // 等待直到执行结束
        task.waitUntilExit()
        // 在命令结束后,获取结果
        let data = output.fileHandleForReading.readDataToEndOfFile()
        
        let resut = String(data: data, encoding: .utf8)
        
        return resut ?? ""
    }
    
}
